module ViewHeader exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)


viewHeader : Html Msg
viewHeader =
    div [ class "row" ]
        [ div [ class "menu", onClick (Msg.GotoHomePage) ]
            [ img [ src "%PUBLIC_URL%/calculator.png" ] [] ]
        , div [ class "menu", onClick (Msg.GotoBrfListPage) ]
            [ img [ src "%PUBLIC_URL%/brflist.png" ] [] ]
        , div [ class "menu", onClick (Msg.GotoInfoPage) ]
            [ img [ src "%PUBLIC_URL%/info.png" ] [] ]
        ]
