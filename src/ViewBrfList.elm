module ViewBrfList exposing (..)

import Html exposing (Html, div, h1, text)
import Model exposing (Model)


viewBrfList : Model -> Html msg
viewBrfList model =
    div []
        [ h1 [] [ text "Dina sparade objekt" ]
        ]
