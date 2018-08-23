module StringUtil exposing (removeSpace, replaceDecimalSeparator, toNumberIfPresentOrZero, twoDecimal, userReplace)

import Regex
import String



-- String conversions


toNumberIfPresentOrZero : String -> Float
toNumberIfPresentOrZero string =
    Maybe.withDefault 0 (String.toFloat (removeSpace (replaceDecimalSeparator string)))


replaceDecimalSeparator : String -> String
replaceDecimalSeparator string =
    String.replace "," "." string


removeSpace : String -> String
removeSpace string =
    String.replace " " "" string


twoDecimal : Float -> String
twoDecimal n =
    String.fromFloat n


userReplace : String -> (Regex.Match -> String) -> String -> String
userReplace userRegex replacer string =
    case Regex.fromString userRegex of
        Nothing ->
            string

        Just regex ->
            Regex.replace regex replacer string
