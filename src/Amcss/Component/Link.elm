module Amcss.Component.Link exposing (active, component, css, hrefNothing, hrefPound, hrefVoid)

import Amcss.Component exposing (attribute, element, property)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Css.component component
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
    , Amcss.Css.selector [ active ]
        [ borderBottomColor StyleGuide.black ]
    , each
        [ Amcss.Css.selectorNotExist [ hrefNothing ]
        , Amcss.Css.selector [ hrefPound ]
        ]
        [ backgroundColor (hex "ff0000")
        , Css.property "border" "none"
        ]
    ]


component =
    Amcss.Component.element "a"


href =
    attribute component "href"


hrefNothing =
    href ""


hrefPound =
    href "#"


hrefVoid =
    href "javascript:void(0)"


active =
    Amcss.Component.property component "a" ""
