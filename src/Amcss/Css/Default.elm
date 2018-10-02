module Amcss.Css.Default exposing (css)

import Css exposing (..)
import Css.Global exposing (..)
import Amcss.Css.StyleGuide as StyleGuide


css =
    [ selector "@font-face"
        [ fontFamilies [ "system" ]
        , fontStyle normal
        , fontWeight (int 400)
        , property "src" "local('.SFNSText-Light'), local('.HelveticaNeueDeskInterface-Light'), local('.LucidaGrandeUI'), local('Ubuntu Light'), local('Segoe UI Light'), local('Roboto-Light'), local('DroidSans'), local('Tahoma')"
        ]
    , body
        [ backgroundColor (hex "f0f0f0")
        , StyleGuide.baseTextColor
        , StyleGuide.systemFont
        , fontSize StyleGuide.baseTextSize
        , lineHeight StyleGuide.baseLineHeight
        , margin zero
        , padding zero
        , overflow hidden
        ]
    , each
        [ header, footer ]
        [ minHeight StyleGuide.minimumHeight
        , padding2 StyleGuide.spacing zero
        ]
    , each
        [ nav, main_, footer ]
        [ display block
        , margin2 zero auto
        , maxWidth (px 1000)
        ]
    , main_
        [ backgroundColor StyleGuide.white
        , padding StyleGuide.spacingLarge
        ]
    , class "test-elem"
        [ backgroundColor (hex "ff0000")
        , border3 (px 1) solid StyleGuide.black
        , width (px 50)
        , height (px 50)
        ]
    ]
