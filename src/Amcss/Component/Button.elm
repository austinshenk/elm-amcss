module Amcss.Component.Button exposing (component, css, disabled, displayGhost, displayNormal, roundedAll, roundedNone, roundedSome, sizeLarge, sizeMedium, sizeSmall)

import Amcss.Component
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Types exposing (Component, Property)
import Css exposing (backgroundColor, border3, borderBox, boxSizing, lineHeight, num, opacity, padding, px, solid, zero)
import Css.Global exposing (Snippet)


css : List Snippet
css =
    [ Amcss.Component.componentToSelector component
        [ border3 (px 1) solid StyleGuide.borderColorEmphasized
        , boxSizing borderBox
        , lineHeight StyleGuide.smallLineHeight
        , StyleGuide.baseTextColor
        ]
    , Amcss.Component.propertyToSelectorNotExist [ disabled ]
        [ StyleGuide.interactable ]
    , Amcss.Component.propertyToSelector [ disabled ]
        [ opacity (num 0.5) ]
    , Amcss.Component.propertyToSelector [ sizeSmall ]
        [ padding StyleGuide.spacing ]
    , Amcss.Component.propertyToSelector [ sizeMedium ]
        [ padding StyleGuide.spacingMedium ]
    , Amcss.Component.propertyToSelector [ sizeLarge ]
        [ padding StyleGuide.spacingLarge ]
    , Amcss.Component.propertyToSelector [ displayNormal ]
        [ backgroundColor StyleGuide.white ]
    , Amcss.Component.propertyToSelector [ displayGhost ]
        [ Css.property "background" "none" ]
    , Amcss.Component.propertyToSelector [ roundedNone ]
        [ Css.borderRadius zero ]
    , Amcss.Component.propertyToSelector [ roundedSome ]
        [ Css.borderRadius StyleGuide.borderRadius ]
    , Amcss.Component.propertyToSelector [ roundedAll ]
        [ Css.borderRadius (px 999) ]
    ]


component : Component
component =
    Amcss.Component.element "button"


display : (Component -> String -> String -> Property) -> String -> Property
display p value =
    p component "d" value


rounded : (Component -> String -> String -> Property) -> String -> Property
rounded p value =
    p component "r" value


size : (Component -> String -> String -> Property) -> String -> Property
size p value =
    p component "s" value


displayNormal : Property
displayNormal =
    display Amcss.Component.defaultProperty "1"


displayGhost : Property
displayGhost =
    display Amcss.Component.property "2"


roundedNone : Property
roundedNone =
    rounded Amcss.Component.defaultProperty "1"


roundedSome : Property
roundedSome =
    rounded Amcss.Component.property "2"


roundedAll : Property
roundedAll =
    rounded Amcss.Component.property "3"


sizeSmall : Property
sizeSmall =
    size Amcss.Component.defaultProperty "1"


sizeMedium : Property
sizeMedium =
    size Amcss.Component.property "2"


sizeLarge : Property
sizeLarge =
    size Amcss.Component.property "3"


disabled : Property
disabled =
    Amcss.Component.attribute component "disabled" ""
