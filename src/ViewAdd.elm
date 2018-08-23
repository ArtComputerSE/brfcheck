module ViewAdd exposing (addBrfFromUrl, fromUri)

import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Model exposing (Model, Parameters)
import Msg
import Regex


addBrfFromUrl : Model -> String -> Html Msg.Msg
addBrfFromUrl model url =
    let
        parameters =
            Model.parametersFromString (fromUri url)
    in
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
                [ img [ class "image-click", src "%PUBLIC_URL%/add.png", onClick (Msg.AddObject parameters) ] []
                ]
            ]
        ]


fromUri : String -> String
fromUri code =
    Regex.replace Regex.All (Regex.regex "\\+") (\_ -> "^") code
        |> Regex.replace Regex.All (Regex.regex (Regex.escape "%20")) (\_ -> " ")
        |> Regex.replace Regex.All (Regex.regex (Regex.escape ".:")) (\_ -> ",")
