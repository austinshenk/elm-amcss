module Amcss.Component.Button exposing (component, css, disabled, displayGhost, displayNormal, roundedAll, roundedNone, roundedSome, sizeLarge, sizeMedium, sizeSmall)

import Amcss.Component exposing (attribute, defaultProperty, element, property)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Html
import Amcss.Types exposing (Component, Property)
import Css exposing (..)
import Css.Global
import Html.Styled as Html


css : List Css.Global.Snippet
css =
    [ Amcss.Css.component component
        [ border3 (px 1) solid StyleGuide.borderColorEmphasized
        , boxSizing borderBox
        , lineHeight StyleGuide.smallLineHeight
        , StyleGuide.baseTextColor
        ]
    , Amcss.Css.selectorNotExist [ disabled ]
        [ StyleGuide.interactable ]
    , Amcss.Css.selector [ disabled ]
        [ opacity (num 0.5) ]
    , Amcss.Css.selector [ sizeSmall ]
        [ padding StyleGuide.spacing ]
    , Amcss.Css.selector [ sizeMedium ]
        [ padding StyleGuide.spacingMedium ]
    , Amcss.Css.selector [ sizeLarge ]
        [ padding StyleGuide.spacingLarge ]
    , Amcss.Css.selector [ displayNormal ]
        [ backgroundColor StyleGuide.white ]
    , Amcss.Css.selector [ displayGhost ]
        [ Css.property "background" "none" ]
    , Amcss.Css.selector [ roundedNone ]
        [ Css.borderRadius zero ]
    , Amcss.Css.selector [ roundedSome ]
        [ Css.borderRadius StyleGuide.borderRadius ]
    , Amcss.Css.selector [ roundedAll ]
        [ Css.borderRadius (px 999) ]
    ]


component : Component
component =
    element "button"


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
    display defaultProperty "1"


displayGhost : Property
displayGhost =
    display Amcss.Component.property "2"


roundedNone : Property
roundedNone =
    rounded defaultProperty "1"


roundedSome : Property
roundedSome =
    rounded Amcss.Component.property "2"


roundedAll : Property
roundedAll =
    rounded Amcss.Component.property "3"


sizeSmall : Property
sizeSmall =
    size defaultProperty "1"


sizeMedium : Property
sizeMedium =
    size Amcss.Component.property "2"


sizeLarge : Property
sizeLarge =
    size Amcss.Component.property "3"


disabled : Property
disabled =
    attribute component "disabled" ""
