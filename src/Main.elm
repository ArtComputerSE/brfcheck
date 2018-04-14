port module Main exposing (..)

import Html exposing (Html, div, h1, input, label, p, table, tbody, td, text, tr)
import Html.Attributes exposing (class)
import Model exposing (Model, Parameters, Route, defaultParameters)
import Msg exposing (Msg)
import Navigation
import UrlParser exposing ((</>))
import ViewBrfList exposing (viewBrfList)
import ViewCalculator exposing (viewCalculator)
import ViewHeader exposing (viewHeader)
import ViewInfoPage exposing (viewInfo)


main : Program (Maybe String) Model Msg
main =
    Navigation.programWithFlags urlParser
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = subscriptions
        }



-- Ports


port setStorage : String -> Cmd msg


port removeStorage : String -> Cmd msg


initialModel : Route -> Parameters -> Model
initialModel route parameters =
    let
        p =
            Debug.log "Parameters " (toString parameters)
    in
    { route = route
    , parameters = parameters
    }


init : Maybe String -> Navigation.Location -> ( Model, Cmd Msg )
init maybeString location =
    let
        l =
            Debug.log "init location" location

        route =
            case UrlParser.parsePath routeParser location of
                Nothing ->
                    Model.HomeRoute

                Just route ->
                    route
    in
    case Debug.log "Maybe stored string" maybeString of
        Just something ->
            ( initialModel route (parametersFromString something), Cmd.none )

        Nothing ->
            ( initialModel route defaultParameters, Cmd.none )


parametersFromString : String -> Parameters
parametersFromString string =
    let
        list =
            Debug.log "list" (String.split ":" string)
    in
    Parameters (pick 1 list) (pick 2 list) (pick 3 list) (pick 4 list) (pick 5 list) (pick 6 list)


pick : Int -> List String -> String
pick n list =
    if n == 1 then
        case List.head list of
            Just head ->
                head

            Nothing ->
                ""
    else
        case List.tail list of
            Just tail ->
                pick (n - 1) tail

            Nothing ->
                ""


parametersToString : Parameters -> String
parametersToString parameters =
    let
        p =
            Debug.log "Parameters to String" parameters
    in
    String.join ":"
        [ parameters.eget_kapital
        , parameters.långfristiga_skulder
        , parameters.andelstal
        , parameters.lägenhetsyta
        , parameters.månadsavgift
        , parameters.beteckning
        ]



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
    , Cmd.batch [ commands, setStorage (parametersToString newParameters) ]
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

        Msg.FollowRoute route ->
            ( { model | route = route }, Cmd.none )



-- PARSING


urlParser : Navigation.Location -> Msg
urlParser location =
    let
        l =
            Debug.log "location" location

        parsed =
            UrlParser.parsePath routeParser location
    in
    case Debug.log "parsed" parsed of
        Nothing ->
            Msg.FollowRoute Model.NotFound

        Just route ->
            Msg.FollowRoute route


postsParser : UrlParser.Parser a a
postsParser =
    UrlParser.s "posts"


addBrfParser : UrlParser.Parser (Model.CodedBrfRecord -> a) a
addBrfParser =
    UrlParser.s "add" </> UrlParser.string


homeParser : UrlParser.Parser a a
homeParser =
    UrlParser.oneOf
        [ UrlParser.s "index.html"
        , UrlParser.s ""
        ]


routeParser : UrlParser.Parser (Route -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Model.AddBrfRoute addBrfParser
        , UrlParser.map Model.HomeRoute homeParser
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "overflow-container" ]
        [ viewHeader
        , viewPage model
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Model.HomeRoute ->
            viewCalculator model

        Model.BrfListRoute ->
            viewBrfList model

        Model.InfoRoute ->
            viewInfo

        Model.AddBrfRoute s ->
            notImplementedYetPage model s

        Model.NotFound ->
            notFoundPage model


notImplementedYetPage : Model -> String -> Html Msg
notImplementedYetPage model code =
    div [] [ text ("This has not been implemented yet. Code: " ++ code) ]


notFoundPage : Model -> Html Msg
notFoundPage model =
    div [] [ text "Not found" ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
