module ViewBrfList exposing (..)

import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (class, src)
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
        , div [ class "cell" ] [ text "Ta bort" ]
        ]


viewBrf : Int -> Parameters -> Html Msg
viewBrf index parameters =
    div [ class "row" ]
        [ div [ class "cell clickable", onClick (Msg.SetCurrent index) ] [ text parameters.beteckning ]
        , div [ class "cell" ] [ text (parameters.lägenhetsyta ++ " kvm") ]
        , div [ class "cell" ] [ text (parameters.månadsavgift ++ " kr") ]
        , div [ class "cell" ]
            [ img [ class "image-click", src "/remove.png", onClick (Msg.RemoveObject index) ] []
            ]
        ]
