module ViewInfoPage exposing (..)

import Html exposing (Html, a, div, h1, h2, p, text)
import Html.Attributes exposing (href, target)


viewInfo : Html msg
viewInfo =
    div []
        [ h1 [] [ text "Information" ]
        , p []
            [ text
                ("När man köper en bostadsrätt blir man medlem i den förening som äger huset, BRF. "
                    ++ "Föreningens ekonomi påverkar varje lägenhets ekonomi så det är viktigt att kontrollera "
                    ++ "hur föreningens finanser ser ut, plus om det är några större underhåll i närtid."
                )
            ]
        , p []
            [ text
                ("Denna app är baserad på en artikel i DN (2017-11-05) och räknar ut nyckeltal för en BRF baserat "
                    ++ "på de uppgifter som du ska ha fått av mäklaren."
                    ++ "Utifrån nyckeltalen så gör appen en utvärdering, också baserad på artikeln. "
                )
            , a
                [ href "https://www.dn.se/ekonomi/din-ekonomi/sa-far-du-koll-pa-ekonomin-i-bostadsrattsforeningen/", target "_blank" ]
                [ text "Här hittar du artikeln." ]
            ]
        , h2 [] [ text "Spara inmatade uppgifter" ]
        , p []
            [ text
                ("Appen är inte kopplad till någon server så allt sparas lokalt i din webbläsare i s.k. \"local storage\"."
                    ++ "Det som du matade in sist kommer alltid upp i kalkylorn."
                    ++ "Om du vill spara något så trycker du på spara-knappen. Då kan du hitta den i listan som du "
                    ++ "når genom att trycka i mitten på det svarta fältet högst upp."
                )
            ]
        , h2 [] [ text "Tips för mobilen" ]
        , p []
            [ text
                ("Om du vill ha snabb åtkomst för den här appen när du använder mobilen så lägg till "
                    ++ "den på startskärmen. Titta efter den funktionen i webbläsarens meny."
                )
            ]
        , h2 [] [ text "Källkod" ]
        , p []
            [ text "Källkoden finns öppet tillgänglig på GitHub. Appen är skriven i Elm. "
            , a [ href "https://github.com/ArtComputerSE/brfcheck", target "_blank" ]
                [ text "Här hittar du källkoden." ]
            ]
        ]
