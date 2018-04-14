module ViewCalculator exposing (viewCalculator)

import Calculator exposing (belåningsgrad, brf_cost_increase, eval_avgift_per_kvm, eval_belåningsgrad, eval_skuldandel_per_kvm, lgh_cost_increase, skuldandel, skuldandel_per_kvm, skuldandel_per_kvm_calc)
import Html exposing (Html, div, h1, input, text)
import Html.Attributes exposing (class, size, step, type_, value)
import Html.Events exposing (on)
import Json.Decode
import Model exposing (..)
import Msg exposing (Msg)
import StringUtil exposing (decimals, toNumberIfPresentOrZero, twoDecimal)


viewCalculator : Model -> Html Msg
viewCalculator model =
    div []
        [ h1 [] [ text "Nyckeltal" ]
        , div []
            [ inputRow "Summa eget kapital:" Msg.UpdateEgetKapital model.parameters.eget_kapital 2 "kr"
            , inputRow "Långfristiga skulder:" Msg.UpdateLångfristigaSkulder model.parameters.långfristiga_skulder 2 "kr"
            , inputRow "Andelstal i %:" Msg.UpdateAndelstal model.parameters.andelstal 3 "%"
            , inputRow "Lägenhetsyta:" Msg.UpdateLägenhetsyta model.parameters.lägenhetsyta 0 "kvm"
            , inputRow "Månadsavgift:" Msg.UpdateMånadsavgift model.parameters.månadsavgift 2 "kr/mån"
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
            , evalRow "Belåningsgrad:" (eval_belåningsgrad (belåningsgrad model))
            , evalRow "Lägenhetens andel av skulden, per kvm:" (eval_skuldandel_per_kvm (skuldandel_per_kvm_calc model))
            , evalRow "Årsavgift per kvm:" (eval_avgift_per_kvm model)
            ]
        ]


inputRow : String -> (String -> msg) -> String -> Int -> String -> Html msg
inputRow label inputMessage currentValue d suffix =
    div [ class "row" ]
        [ div [ class "col-left" ] [ text label ]
        , div [ class "col-center" ]
            [ input [ onMyBlur inputMessage, value (decimals d (toNumberIfPresentOrZero currentValue)), size 15, step "any" ] []
            ]
        , div [ class "col-right" ] [ text suffix ]
        ]


onMyBlur : (String -> msg) -> Html.Attribute msg
onMyBlur tagger =
    on "blur" (Json.Decode.map tagger targetValue)


targetValue : Json.Decode.Decoder String
targetValue =
    Json.Decode.at [ "target", "value" ] Json.Decode.string


resultRow : String -> String -> String -> Html msg
resultRow label result suffix =
    div [ class "row" ]
        [ div [ class "col-left" ] [ text label ]
        , div [ class "col-center" ] [ text result ]
        , div [ class "col-right" ] [ text suffix ]
        ]


evalRow : String -> String -> Html msg
evalRow label result =
    div [ class "row" ]
        [ div [ class "col-left" ] [ text label ]
        , div [ class "col-center" ] [ text result ]
        ]
