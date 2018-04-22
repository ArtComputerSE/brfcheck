module ViewAdd exposing (..)

import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Model exposing (Model, Parameters)
import Msg exposing (..)


addBrfFromUrl : Model -> Parameters -> Html Msg
addBrfFromUrl model parameters =
    div []
        [ h1 []
            [ text "Lägg till" ]
        , div [ class "row" ]
            [ div [ class "cell" ] [ text "Beteckning" ]
            , div [ class "cell" ] [ text "Lägenhetsyta" ]
            , div [ class "cell" ] [ text "Månadsavgift" ]
            , div [ class "cell" ] [ text "Lägg till" ]
            ]
        , div [ class "row" ]
            [ div [ class "cell " ] [ text parameters.beteckning ]
            , div [ class "cell" ] [ text (parameters.lägenhetsyta ++ " kvm") ]
            , div [ class "cell" ] [ text (parameters.månadsavgift ++ " kr") ]
            , div [ class "cell" ]
                [ img [ class "image-click", src "add.png", onClick (Msg.AddObject parameters) ] []
                ]
            ]
        ]
