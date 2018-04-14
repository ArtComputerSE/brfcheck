module Model exposing (..)

-- MODEL


type alias Model =
    { route : Route
    , parameters : Parameters
    }


type alias Parameters =
    { eget_kapital : String
    , långfristiga_skulder : String
    , andelstal : String
    , lägenhetsyta : String
    , månadsavgift : String
    }


defaultParameters : Parameters
defaultParameters =
    { eget_kapital = "0"
    , långfristiga_skulder = "0"
    , andelstal = "0"
    , lägenhetsyta = "0"
    , månadsavgift = "0"
    }



-- ROUTES


type alias CodedBrfRecord =
    String


type Route
    = HomeRoute
    | AddBrfRoute CodedBrfRecord
    | NotFound
