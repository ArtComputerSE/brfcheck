module Msg exposing (..)

import Model exposing (Route)


type Msg
    = UpdateEgetKapital String
    | UpdateLångfristigaSkulder String
    | UpdateAndelstal String
    | UpdateLägenhetsyta String
    | UpdateMånadsavgift String
    | UpdateBeteckning String
    | Spara
    | SetCurrent Int
    | FollowRoute Route
