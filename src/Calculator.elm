module Calculator exposing (belåningsgrad, brf_cost_increase, brf_cost_increase_calc, eval_avgift_per_kvm, eval_belåningsgrad, eval_skuldandel_per_kvm, lgh_cost_increase, skuldandel, skuldandel_per_kvm, skuldandel_per_kvm_calc)

import Model exposing (Parameters)
import StringUtil exposing (toNumberIfPresentOrZero, twoDecimal)



-- Calculations


belåningsgrad : Parameters -> String
belåningsgrad parameters =
    let
        kapital =
            toNumberIfPresentOrZero parameters.eget_kapital

        skulder =
            toNumberIfPresentOrZero parameters.långfristiga_skulder

        summa =
            kapital + skulder
    in
    if summa == 0 then
        ""

    else
        twoDecimal ((skulder / summa) * 100)


skuldandel : Parameters -> String
skuldandel parameters =
    let
        skulder =
            toNumberIfPresentOrZero parameters.långfristiga_skulder

        andel =
            toNumberIfPresentOrZero parameters.andelstal
    in
    if skulder == 0 || andel == 0 then
        ""

    else
        twoDecimal (skulder * andel / 100)


skuldandel_per_kvm : Parameters -> String
skuldandel_per_kvm parameters =
    twoDecimal (skuldandel_per_kvm_calc parameters)


skuldandel_per_kvm_calc : Parameters -> Float
skuldandel_per_kvm_calc parameters =
    let
        skulder =
            toNumberIfPresentOrZero parameters.långfristiga_skulder

        andel =
            toNumberIfPresentOrZero parameters.andelstal

        yta =
            toNumberIfPresentOrZero parameters.lägenhetsyta
    in
    if skulder == 0 || andel == 0 then
        0.0

    else if yta == 0 then
        0.0

    else
        (skulder * andel / 100) / yta


brf_cost_increase : Parameters -> String
brf_cost_increase parameters =
    twoDecimal (brf_cost_increase_calc parameters)


brf_cost_increase_calc : Parameters -> Float
brf_cost_increase_calc parameters =
    toNumberIfPresentOrZero parameters.långfristiga_skulder * 0.01 / 12


lgh_cost_increase : Parameters -> String
lgh_cost_increase parameters =
    twoDecimal (toNumberIfPresentOrZero parameters.andelstal * 0.01 * brf_cost_increase_calc parameters)



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


eval_avgift_per_kvm : Parameters -> String
eval_avgift_per_kvm parameters =
    let
        monthly =
            toNumberIfPresentOrZero parameters.månadsavgift

        yta =
            toNumberIfPresentOrZero parameters.lägenhetsyta

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
