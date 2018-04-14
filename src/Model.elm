module Model exposing (..)

-- MODEL


type alias Model =
    { route : Route
    , parameters : Parameters
    , saved : List Parameters
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



-- ROUTES


type alias CodedBrfRecord =
    String


type Route
    = HomeRoute
    | BrfListRoute
    | InfoRoute
    | AddBrfRoute CodedBrfRecord
    | NotFound
