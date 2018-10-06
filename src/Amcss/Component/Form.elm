module Amcss.Component.Form exposing (css, input, inputDisabled, inputRequired, select, selectDisabled, selectRequired, typeOfCheckbox, typeOfColor, typeOfDate, typeOfRadio, typeOfText)

import Amcss.Component exposing (attribute, element)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Types exposing (Property)
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ form
        [ margin3 zero zero StyleGuide.spacing ]
    , each
        [ Amcss.Css.selector [ typeOfRadio ]
        , Amcss.Css.selector [ typeOfCheckbox ]
        , Amcss.Css.component select
        , label
        ]
        [ cursor pointer ]
    , each
        [ Amcss.Css.component input
        , Amcss.Css.component select
        ]
        [ backgroundColor StyleGuide.white
        , border3 (px 1) solid StyleGuide.borderColor
        , color StyleGuide.black
        , Css.borderRadius StyleGuide.borderRadius
        , StyleGuide.systemFont
        , fontSize StyleGuide.baseTextSize
        , lineHeight StyleGuide.baseLineHeight
        , important (padding StyleGuide.spacing)
        , Css.property "transition" "background .2s, border-color .2s"
        ]
    , each
        [ Amcss.Css.selector [ typeOfRadio ]
        , Amcss.Css.selector [ typeOfCheckbox ]
        ]
        [ Css.property "-webkit-appearance" "none"
        , width (Css.rem 2)
        , height (Css.rem 2)
        , position relative
        , after
            [ Css.property "content" "''"
            , backgroundColor StyleGuide.black
            , Css.borderRadius StyleGuide.borderRadius
            , position absolute
            , top StyleGuide.spacing
            , bottom StyleGuide.spacing
            , left StyleGuide.spacing
            , right StyleGuide.spacing
            , opacity zero
            , Css.property "transition" "opacity .15s"
            ]
        , checked
            [ after [ opacity (num 1) ] ]
        ]
    , Amcss.Css.selector [ typeOfRadio ]
        [ Css.borderRadius (px 999)
        , checked
            [ after
                [ Css.borderRadius (px 999) ]
            ]
        ]
    , each
        [ Amcss.Css.selectorNotExist [ inputDisabled ]
        , Amcss.Css.selectorNotExist [ selectDisabled ]
        ]
        [ hover
            [ backgroundColor (hex "cfcfcf")
            , Css.borderColor StyleGuide.borderColorEmphasized
            , outline none
            ]
        , focus
            [ backgroundColor (hex "cfcfcf")
            , Css.borderColor StyleGuide.borderColorEmphasized
            , outline none
            ]
        ]
    , each
        [ Amcss.Css.selector [ inputDisabled ]
        , Amcss.Css.selector [ selectDisabled ]
        ]
        [ opacity (num 0.5) ]
    , each
        [ Amcss.Css.selector [ inputRequired ]
        , Amcss.Css.selector [ selectRequired ]
        ]
        [ Css.borderColor StyleGuide.borderColorRequired
        , hover [ Css.borderColor StyleGuide.borderColorEmphasized ]
        , focus [ Css.borderColor StyleGuide.borderColorEmphasized ]
        ]
    , option
        [ backgroundColor StyleGuide.white
        , StyleGuide.systemFont
        , fontSize StyleGuide.baseTextSize
        , lineHeight StyleGuide.baseLineHeight
        , padding StyleGuide.spacing
        ]
    ]


input =
    element "input"


typeOf : String -> Property
typeOf =
    attribute input "type"


typeOfText =
    typeOf "text"


typeOfRadio =
    typeOf "radio"


typeOfCheckbox =
    typeOf "checkbox"


typeOfDate =
    typeOf "date"


typeOfColor =
    typeOf "color"


inputDisabled =
    attribute input "disabled" ""


inputRequired =
    attribute input "required" ""


select =
    element "select"


selectDisabled =
    attribute select "disabled" ""


selectRequired =
    attribute select "required" ""
