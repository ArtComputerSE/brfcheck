module ViewBrfList exposing (..)

import Html exposing (Html, div, h1, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model, Parameters)
import Msg exposing (..)


viewBrfList : Model -> Html Msg
viewBrfList model =
    div []
        [ h1 [] [ text "Dina sparade objekt" ]
        , headers
        , div [] (List.indexedMap viewBrf model.saved)
        ]


headers : Html msg
headers =
    div [ class "row" ]
        [ div [ class "cell" ] [ text "Beteckning" ]
        , div [ class "cell" ] [ text "Lägenhetsyta" ]
        , div [ class "cell" ] [ text "Månadsavgift" ]
        ]


viewBrf : Int -> Parameters -> Html Msg
viewBrf index parameters =
    div [ class "row" ]
        [ div [ class "cell", onClick (Msg.SetCurrent index) ] [ text parameters.beteckning ]
        , div [ class "cell" ] [ text (parameters.lägenhetsyta ++ " kvm") ]
        , div [ class "cell" ] [ text (parameters.månadsavgift ++ " kr") ]
        ]
