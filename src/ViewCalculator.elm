module ViewCalculator exposing (viewCalculator)

import Calculator exposing (belåningsgrad, brf_cost_increase, eval_avgift_per_kvm, eval_belåningsgrad, eval_skuldandel_per_kvm, lgh_cost_increase, skuldandel, skuldandel_per_kvm, skuldandel_per_kvm_calc)
import Html exposing (Html, div, h1, input, text)
import Html.Attributes exposing (class, size, step, type_, value)
import Html.Events exposing (on)
import Json.Decode
import Model exposing (..)
import Msg exposing (Msg)
import StringUtil exposing (toNumberIfPresentOrZero, twoDecimal)


viewCalculator : Model -> Html Msg
viewCalculator model =
    div []
        [ h1 [] [ text "Nyckeltal" ]
        , div []
            [ inputRow "Summa eget kapital:" Msg.UpdateEgetKapital model.parameters.eget_kapital "kr"
            , inputRow "Långfristiga skulder:" Msg.UpdateLångfristigaSkulder model.parameters.långfristiga_skulder "kr"
            , inputRow "Andelstal i %:" Msg.UpdateAndelstal model.parameters.andelstal "%"
            , inputRow "Lägenhetsyta:" Msg.UpdateLägenhetsyta model.parameters.lägenhetsyta "kvm"
            , inputRow "Månadsavgift:" Msg.UpdateMånadsavgift model.parameters.månadsavgift "kr/mån"
            ]
        , h1 [] [ text "Analys" ]
        , div []
            [ resultRow "Fastighetens belåningsgrad: " (belåningsgrad model) "%"
            , resultRow "Lägenhetens del av skulden: " (skuldandel model) " kr"
            , resultRow "Lägenhetens del av skulden per kvadratmeter: " (skuldandel_per_kvm model) "kr"
            , resultRow "Föreningens kostnadsökning vid 1% räntehöjning: " (brf_cost_increase model) "kr/mån"
            ]
        , h1 [] [ text "Utvärdering" ]
        , div []
            [ resultRow "Lägenhetens kostnadsökning vid en räntehöjning om 1%: " (lgh_cost_increase model) "kr/mån"
            , resultRow "Belåningsgrad:" (eval_belåningsgrad (belåningsgrad model)) ""
            , resultRow "Lägenhetens andel av skulden, per kvm:" (eval_skuldandel_per_kvm (skuldandel_per_kvm_calc model)) ""
            , resultRow "Årsavgift per kvm:" (eval_avgift_per_kvm model) ""
            ]
        ]


inputRow : String -> (String -> msg) -> String -> String -> Html msg
inputRow label inputMessage currentValue suffix =
    div [ class "row" ]
        [ div [ class "cell" ] [ text label ]
        , div [ class "col-center" ]
            [ input [ onMyBlur inputMessage, value (twoDecimal (toNumberIfPresentOrZero currentValue)), size 15, step "any" ] []
            ]
        , div [ class "cell" ] [ text suffix ]
        ]


onMyBlur : (String -> msg) -> Html.Attribute msg
onMyBlur tagger =
    on "blur" (Json.Decode.map tagger targetValue)


targetValue : Json.Decode.Decoder String
targetValue =
    Json.Decode.at [ "target", "value" ] Json.Decode.string


resultRow label result suffix =
    div [ class "row" ]
        [ div [ class "cell" ] [ text label ]
        , div [ class "col-center" ] [ text result ]
        , div [ class "cell" ] [ text suffix ]
        ]
