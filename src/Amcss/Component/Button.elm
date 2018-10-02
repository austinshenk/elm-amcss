module Amcss.Component.Button exposing (component, componentWithAttributes, css, defaultComponent, disabled, displayGhost, displayNormal, roundedAll, roundedNone, roundedSome, sizeLarge, sizeMedium, sizeSmall)

import Amcss exposing (Component, Property, attribute, defaultProperty, element, property)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Html
import Css exposing (..)
import Css.Global
import Html.Styled as Html


defaultComponent : List (Html.Html msg) -> Html.Html msg
defaultComponent =
    component []


component : List Property -> List (Html.Html msg) -> Html.Html msg
component properties =
    componentWithAttributes properties []


componentWithAttributes : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentWithAttributes =
    Amcss.Html.componentToElement Html.button


css : List Css.Global.Snippet
css =
    [ Amcss.Css.component button
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


button : Component
button =
    element "button"


display : (Component -> String -> String -> Property) -> String -> Property
display p value =
    p button "d" value


rounded : (Component -> String -> String -> Property) -> String -> Property
rounded p value =
    p button "r" value


size : (Component -> String -> String -> Property) -> String -> Property
size p value =
    p button "s" value


displayNormal : Property
displayNormal =
    display defaultProperty "1"


displayGhost : Property
displayGhost =
    display Amcss.property "2"


roundedNone : Property
roundedNone =
    rounded defaultProperty "1"


roundedSome : Property
roundedSome =
    rounded Amcss.property "2"


roundedAll : Property
roundedAll =
    rounded Amcss.property "3"


sizeSmall : Property
sizeSmall =
    size defaultProperty "1"


sizeMedium : Property
sizeMedium =
    size Amcss.property "2"


sizeLarge : Property
sizeLarge =
    size Amcss.property "3"


disabled : Property
disabled =
    attribute button "disabled" ""
