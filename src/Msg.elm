module Msg exposing (..)

import Model exposing (Parameters, Route)


type Msg
    = UpdateEgetKapital String
    | UpdateLångfristigaSkulder String
    | UpdateAndelstal String
    | UpdateLägenhetsyta String
    | UpdateMånadsavgift String
    | UpdateBeteckning String
    | Spara
    | SetCurrent Int
    | RemoveObject Int
    | AddObject Parameters
    | FollowRoute Route
    | GotoHomePage
    | GotoBrfListPage
    | GotoInfoPage
