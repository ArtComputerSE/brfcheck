module StringUtil exposing (..)

import FormatNumber exposing (format)
import Regex


-- String conversions


toNumberIfPresentOrZero : String -> Float
toNumberIfPresentOrZero string =
    Result.withDefault 0 (String.toFloat (removeSpace (replaceDecimalSeparator string)))


replaceDecimalSeparator : String -> String
replaceDecimalSeparator string =
    Regex.replace Regex.All (Regex.regex ",") (\_ -> ".") string


removeSpace : String -> String
removeSpace string =
    Regex.replace Regex.All (Regex.regex " ") (\_ -> "") string


twoDecimal : Float -> String
twoDecimal n =
    decimals 2 n


decimals : Int -> Float -> String
decimals d n =
    format { decimals = d, thousandSeparator = " ", decimalSeparator = ",", negativePrefix = "−", negativeSuffix = "" } n
