module Calculator exposing (..)

import Model exposing (Model)
import StringUtil exposing (toNumberIfPresentOrZero, twoDecimal)


-- Calculations


belåningsgrad : Model -> String
belåningsgrad model =
    let
        kapital =
            toNumberIfPresentOrZero model.parameters.eget_kapital

        skulder =
            toNumberIfPresentOrZero model.parameters.långfristiga_skulder

        summa =
            kapital + skulder
    in
    if summa == 0 then
        ""
    else
        twoDecimal ((skulder / summa) * 100)


skuldandel : Model -> String
skuldandel model =
    let
        skulder =
            toNumberIfPresentOrZero model.parameters.långfristiga_skulder

        andel =
            toNumberIfPresentOrZero model.parameters.andelstal
    in
    if skulder == 0 || andel == 0 then
        ""
    else
        twoDecimal (skulder * andel / 100)


skuldandel_per_kvm : Model -> String
skuldandel_per_kvm model =
    twoDecimal (skuldandel_per_kvm_calc model)


skuldandel_per_kvm_calc : Model -> Float
skuldandel_per_kvm_calc model =
    let
        skulder =
            toNumberIfPresentOrZero model.parameters.långfristiga_skulder

        andel =
            toNumberIfPresentOrZero model.parameters.andelstal

        yta =
            toNumberIfPresentOrZero model.parameters.lägenhetsyta
    in
    if skulder == 0 || andel == 0 then
        0.0
    else if yta == 0 then
        0.0
    else
        (skulder * andel / 100) / yta


brf_cost_increase : Model -> String
brf_cost_increase model =
    twoDecimal (brf_cost_increase_calc model)


brf_cost_increase_calc : Model -> Float
brf_cost_increase_calc model =
    toNumberIfPresentOrZero model.parameters.långfristiga_skulder * 0.01 / 12


lgh_cost_increase : Model -> String
lgh_cost_increase model =
    twoDecimal (toNumberIfPresentOrZero model.parameters.andelstal * 0.01 * brf_cost_increase_calc model)



-- Evaluations


eval_belåningsgrad : String -> String
eval_belåningsgrad fastighetBelåningString =
    let
        fastighetsBelåningsgrad =
            toNumberIfPresentOrZero fastighetBelåningString
    in
    if fastighetsBelåningsgrad <= 25 then
        "OK, mindre än 25%."
    else if fastighetsBelåningsgrad <= 50 then
        "Gränsfall, 25-50%."
    else
        "Se upp! Över 50%."


eval_skuldandel_per_kvm : Float -> String
eval_skuldandel_per_kvm spkvm =
    if spkvm >= 9000 then
        "Hög, över 9000 kr."
    else if spkvm >= 6000 then
        "Måttlig till hög, 6000 - 9000 kr."
    else if spkvm > 3000 then
        "Måttlig till låg, 3000 - 6000 kr."
    else
        "Låg, under 3000 kr."


eval_avgift_per_kvm : Model -> String
eval_avgift_per_kvm model =
    let
        monthly =
            toNumberIfPresentOrZero model.parameters.månadsavgift

        yta =
            toNumberIfPresentOrZero model.parameters.lägenhetsyta

        avgift =
            if yta > 0 then
                monthly * 12 / yta
            else
                0
    in
    if avgift >= 900 then
        "Hög, över 900 kr"
    else if avgift >= 650 then
        "Måttlig till hög, 650 - 900 kr."
    else if avgift > 300 then
        "Måttlig till låg, 300 - 650 kr."
    else
        "Låg, under 300 kr."
