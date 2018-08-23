port module Main exposing (addBrfParser, addObjectAndGoToList, brfListParser, homeParser, infoParser, init, initialModel, main, notFoundPage, removeFromList, removeStorage, routeParser, setCurrent, setStorage, subscriptions, update, updateWithStorage, urlFromRoute, urlParser, view, viewPage)

import Browser
import Browser.Navigation
import Html exposing (Html, div, h1, input, label, p, table, tbody, td, text, tr)
import Html.Attributes exposing (class)
import Model exposing (Model, Parameters, Route)
import Msg exposing (Msg)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s, string)
import ViewAdd exposing (addBrfFromUrl)
import ViewBrfList exposing (viewBrfList)
import ViewCalculator exposing (viewCalculator)
import ViewHeader exposing (viewHeader)
import ViewInfoPage exposing (viewInfo)


main : Program (Maybe String) Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = subscriptions
        }



-- Ports


port setStorage : String -> Cmd msg


port removeStorage : String -> Cmd msg


initialModel : Url.Url -> List Parameters -> Model
initialModel location parameters =
    let
        p =
            Debug.log "Parameters " (toString parameters)

        current =
            Maybe.withDefault Model.defaultParameters (List.head parameters)

        route =
            Maybe.withDefault Model.HomeRoute (Parser.parsePath routeParser location)
    in
    { route = route
    , parameters = current
    , saved = parameters
    , location = location
    }


init : Maybe String -> Url.Url -> ( Model, Cmd Msg )
init maybeString location =
    let
        l =
            Debug.log "init location" (Url.toString location)
    in
    case Debug.log "Maybe stored string" maybeString of
        Just something ->
            ( initialModel location (Model.restore something), Cmd.none )

        Nothing ->
            ( initialModel location [ Model.defaultParameters ], Cmd.none )



-- UPDATE


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, commands ) =
            update msg model

        newParameters =
            newModel.parameters
    in
    ( newModel
    , Cmd.batch [ commands, setStorage (Model.store newParameters model.saved) ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        params =
            model.parameters
    in
    case msg of
        Msg.UpdateEgetKapital nytt_eget_kapital ->
            ( { model | parameters = { params | eget_kapital = nytt_eget_kapital } }, Cmd.none )

        Msg.UpdateLångfristigaSkulder nytt_långfristiga_skulder ->
            ( { model | parameters = { params | långfristiga_skulder = nytt_långfristiga_skulder } }, Cmd.none )

        Msg.UpdateAndelstal nytt_andelstal ->
            ( { model | parameters = { params | andelstal = nytt_andelstal } }, Cmd.none )

        Msg.UpdateLägenhetsyta ny_lägenhetsyta ->
            ( { model | parameters = { params | lägenhetsyta = ny_lägenhetsyta } }, Cmd.none )

        Msg.UpdateMånadsavgift ny_månadsavgift ->
            ( { model | parameters = { params | månadsavgift = ny_månadsavgift } }, Cmd.none )

        Msg.UpdateBeteckning ny_beteckning ->
            ( { model | parameters = { params | beteckning = ny_beteckning } }, Cmd.none )

        Msg.Spara ->
            ( { model | saved = params :: model.saved }, Cmd.none )

        Msg.SetCurrent index ->
            ( setCurrent index model, Navigation.newUrl (urlFromRoute Model.HomeRoute) )

        Msg.RemoveObject index ->
            ( { model | saved = removeFromList index model.saved }, Cmd.none )

        Msg.AddObject parameters ->
            ( { model | saved = parameters :: model.saved }, Navigation.newUrl (urlFromRoute Model.BrfListRoute) )

        Msg.FollowRoute route ->
            ( { model | route = route }, Cmd.none )

        Msg.GotoHomePage ->
            ( model, Navigation.newUrl (urlFromRoute Model.HomeRoute) )

        Msg.GotoBrfListPage ->
            ( model, Navigation.newUrl (urlFromRoute Model.BrfListRoute) )

        Msg.GotoInfoPage ->
            ( model, Navigation.newUrl (urlFromRoute Model.InfoRoute) )


setCurrent : Int -> Model -> Model
setCurrent index model =
    let
        newCurrent =
            Model.pick index Model.defaultParameters model.saved

        newSaved =
            removeFromList index model.saved
    in
    Model Model.HomeRoute newCurrent (newCurrent :: newSaved) model.location


removeFromList : Int -> List a -> List a
removeFromList index list =
    List.append (List.take index list) (List.drop (index + 1) list)


addObjectAndGoToList : Model -> Parameters -> Model
addObjectAndGoToList model parameters =
    Model Model.BrfListRoute parameters (parameters :: model.saved) model.location



-- PARSING
{-
   urlParser : Url.Url -> Msg
   urlParser location =
       let
           l =
               Debug.log "location" (Url.toString location)

           parsed =
               Parser.parsePath routeParser location
       in
       case Debug.log "parsed" parsed of
           Nothing ->
               Msg.FollowRoute Model.NotFound

           Just route ->
               Msg.FollowRoute route
-}


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Model.AddBrfRoute addBrfParser
        , map Model.BrfListRoute brfListParser
        , map Model.InfoRoute infoParser
        , map Model.HomeRoute homeParser
        ]


addBrfParser : Parser (Model.CodedBrfRecord -> a) a
addBrfParser =
    oneOf
        [ s "add" </> string
        , s "brfcheck" </> s "add" </> string
        ]


brfListParser : Parser a a
brfListParser =
    oneOf
        [ s "list"
        , s "brfcheck" </> s "list"
        ]


infoParser : Parser a a
infoParser =
    oneOf
        [ s "info"
        , s "brfcheck" </> s "info"
        ]


homeParser : Parser a a
homeParser =
    oneOf
        [ s "index.html"
        , s ""
        , s "brfcheck"
        ]


urlFromRoute : Route -> String
urlFromRoute route =
    case route of
        Model.HomeRoute ->
            "%PUBLIC_URL%/"

        Model.BrfListRoute ->
            "%PUBLIC_URL%/list"

        Model.InfoRoute ->
            "%PUBLIC_URL%/info"

        Model.AddBrfRoute _ ->
            "%PUBLIC_URL%/add"

        Model.NotFound ->
            "%PUBLIC_URL%/notfound"



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewHeader
        , viewPage model
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Model.HomeRoute ->
            viewCalculator model.parameters

        Model.BrfListRoute ->
            viewBrfList model

        Model.InfoRoute ->
            viewInfo

        Model.AddBrfRoute code ->
            ViewAdd.addBrfFromUrl model code

        Model.NotFound ->
            notFoundPage model


notFoundPage : Model -> Html Msg
notFoundPage model =
    div [] [ text "Not found" ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
