module ViewAdd exposing (addBrfFromUrl, fromUri)

import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Model exposing (Model, Parameters)
import Msg
import StringUtil exposing (userReplace)


addBrfFromUrl : Model -> Maybe String -> Html Msg.Msg
addBrfFromUrl model url =
    let
        parameters =
            case url of
                Nothing ->
                    Model.defaultParameters

                Just value ->
                    Model.parametersFromString (fromUri value)
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
    userReplace "\\+" (\_ -> "^") code
        |> userReplace "%20" (\_ -> " ")
        |> userReplace ".:" (\_ -> ",")
