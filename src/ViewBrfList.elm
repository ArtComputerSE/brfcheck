module ViewBrfList exposing (viewBrfList)

import Browser.Navigation
import Html exposing (Html, div, h1, img, p, span, text)
import Html.Attributes exposing (attribute, class, id, src)
import Html.Events exposing (onClick)
import Model exposing (Model, Parameters)
import Msg
import Regex
import StringUtil exposing (userReplace)
import Url


viewBrfList : Model -> Html Msg.Msg
viewBrfList model =
    div []
        [ h1 [] [ text "Dina sparade objekt" ]
        , headers
        , div [] (List.indexedMap (viewBrf (baseUrl model.location)) model.saved)
        ]


headers : Html msg
headers =
    div [ class "row" ]
        [ div [ class "cell" ] [ text "Beteckning" ]
        , div [ class "cell" ] [ text "Lägenhetsyta" ]
        , div [ class "cell" ] [ text "Månadsavgift" ]
        , div [ class "cell" ] [ text "Ta bort" ]
        , div [ class "cell" ] [ text "Urklipp" ]
        ]


viewBrf : String -> Int -> Parameters -> Html Msg.Msg
viewBrf url index parameters =
    div [ class "row" ]
        [ div [ class "cell clickable", onClick (Msg.SetCurrent index) ] [ text parameters.beteckning ]
        , div [ class "cell" ] [ text (parameters.lägenhetsyta ++ " kvm") ]
        , div [ class "cell" ] [ text (parameters.månadsavgift ++ " kr") ]
        , div [ class "cell" ]
            [ img [ class "image-click", src "%PUBLIC_URL%/remove.png", onClick (Msg.RemoveObject index) ] []
            ]
        , div [ class "cell" ]
            [ div []
                [ img
                    [ class "copy-button"
                    , src "%PUBLIC_URL%/clipboard.png"
                    , attribute "data-clipboard-target" ("#parameters" ++ String.fromInt index)
                    ]
                    []
                , span
                    [ class "hidden-span", id ("parameters" ++ String.fromInt index) ]
                    [ text (url ++ encode (Model.parametersToString parameters)) ]
                ]
            ]
        ]


baseUrl : Url.Url -> String
baseUrl url =
    Url.toString url |> userReplace "list" (\_ -> "brfcheck/?object=")


encode : String -> String
encode code =
    userReplace "\\^" (\_ -> "+") code
        |> userReplace " " (\_ -> "%20")
        |> userReplace "," (\_ -> ".:")
