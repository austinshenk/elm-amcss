module Amcss.Component.Link exposing (active, component, css)

import Amcss.Component exposing (attribute, element, property)
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Types exposing (Component, Property)
import Css exposing (backgroundColor, borderBottom3, borderBottomColor, borderBox, borderTopLeftRadius, borderTopRightRadius, boxSizing, display, focus, hex, hover, inlineBlock, minHeight, minWidth, none, padding3, px, solid, textDecoration, zero)
import Css.Global exposing (Snippet, each)


css : List Snippet
css =
    [ Amcss.Component.componentToSelector component
        [ borderBottom3 (px 2) solid StyleGuide.borderColor
        , borderTopLeftRadius (px 2)
        , borderTopRightRadius (px 2)
        , boxSizing borderBox
        , StyleGuide.baseTextColor
        , display inlineBlock
        , StyleGuide.systemFont
        , minHeight StyleGuide.minimumHeight
        , minWidth StyleGuide.minimumHeight
        , padding3 zero StyleGuide.spacing zero
        , textDecoration none
        , StyleGuide.interactable
        , hover
            [ borderBottomColor (hex "101010") ]
        , focus
            [ borderBottomColor (hex "101010") ]
        ]
    , Amcss.Component.propertyToSelector [ active ]
        [ borderBottomColor StyleGuide.black ]
    , each
        [ Amcss.Component.propertyToSelector [ hrefNothing ]
        , Amcss.Component.propertyToSelector [ hrefPound ]
        ]
        [ backgroundColor (hex "ff0000")
        , Css.property "border" "none"
        ]
    ]


component : Component
component =
    Amcss.Component.element "a"


href : String -> Property
href =
    attribute component "href"


hrefNothing : Property
hrefNothing =
    href ""


hrefPound : Property
hrefPound =
    href "#"


hrefVoid : Property
hrefVoid =
    href "javascript:void(0)"


active : Property
active =
    Amcss.Component.property component "a" ""
