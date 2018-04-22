module ViewHeader exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)


viewHeader : Html Msg
viewHeader =
    div [ class "row" ]
        [ div [ class "menu", onClick (Msg.FollowRoute Model.HomeRoute) ]
            [ img [ src "calculator.png" ] [] ]
        , div [ class "menu", onClick (Msg.FollowRoute Model.BrfListRoute) ]
            [ img [ src "brflist.png" ] [] ]
        , div [ class "menu", onClick (Msg.FollowRoute Model.InfoRoute) ]
            [ img [ src "info.png" ] [] ]
        ]
