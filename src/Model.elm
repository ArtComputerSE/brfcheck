module Model exposing (CodedBrfRecord, Model, Parameters, Route(..), defaultParameters, parameterListSplitter, parameterSplitter, parametersFromString, parametersToString, pick, restore, store)

import Browser.Navigation as Navigation
import Url



-- MODEL


type alias Model =
    { route : Route
    , parameters : Parameters
    , saved : List Parameters
    , key : Navigation.Key
    , location : Url.Url
    }


type alias Parameters =
    { eget_kapital : String
    , långfristiga_skulder : String
    , andelstal : String
    , lägenhetsyta : String
    , månadsavgift : String
    , beteckning : String
    }


defaultParameters : Parameters
defaultParameters =
    { eget_kapital = "0"
    , långfristiga_skulder = "0"
    , andelstal = "0"
    , lägenhetsyta = "0"
    , månadsavgift = "0"
    , beteckning = ""
    }


restore : String -> List Parameters
restore encoded =
    let
        e =
            Debug.log "Restoring " encoded
    in
    String.split parameterListSplitter encoded |> List.map parametersFromString


store : Parameters -> List Parameters -> String
store current list =
    let
        --        x =
        --            Debug.log "Store "
        --                (Debug.toString list)
        saved =
            Maybe.withDefault [] (List.tail list)
    in
    List.map parametersToString (current :: saved) |> String.join parameterListSplitter


parameterListSplitter : String
parameterListSplitter =
    "|"


parameterSplitter : String
parameterSplitter =
    "^"


parametersFromString : String -> Parameters
parametersFromString string =
    let
        list =
            Debug.log "list" (String.split parameterSplitter string)
    in
    Parameters (pick 0 "" list) (pick 1 "" list) (pick 2 "" list) (pick 3 "" list) (pick 4 "" list) (pick 5 "" list)


pick : Int -> s -> List s -> s
pick n def list =
    if n == 0 then
        Maybe.withDefault def (List.head list)

    else
        case List.tail list of
            Just tail ->
                pick (n - 1) def tail

            Nothing ->
                def


parametersToString : Parameters -> String
parametersToString parameters =
    --    let
    --        p =
    --            Debug.log "Parameters to String" parameters
    --    in
    String.join parameterSplitter
        [ parameters.eget_kapital
        , parameters.långfristiga_skulder
        , parameters.andelstal
        , parameters.lägenhetsyta
        , parameters.månadsavgift
        , parameters.beteckning
        ]



-- ROUTES


type alias CodedBrfRecord =
    String


type Route
    = HomeRoute
    | BrfListRoute
    | InfoRoute
    | AddBrfRoute (Maybe String)
    | NotFound
