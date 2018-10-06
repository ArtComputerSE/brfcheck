module Msg exposing (Msg(..))

import Browser
import Model exposing (Parameters, Route)
import Url


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
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotoHomePage
    | GotoBrfListPage
    | GotoInfoPage
