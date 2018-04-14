module ViewHeader exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)


viewHeader : Html Msg
viewHeader =
    div [ class "row" ]
        [ div [ class "menu-left", onClick (Msg.FollowRoute Model.HomeRoute) ]
            [ text "C" ]
        , div [ class "menu-center", onClick (Msg.FollowRoute Model.BrfListRoute) ]
            [ text "L" ]
        , div [ class "menu-right", onClick (Msg.FollowRoute Model.InfoRoute) ]
            [ text "I" ]
        ]
