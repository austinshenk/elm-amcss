module Amcss.Css.StyleGuide exposing (baseLineHeight, baseTextColor, baseTextSize, black, border1px, borderColor, borderColorDisabled, borderColorEmphasized, borderColorRequired, borderRadius, interactable, lobotomizedOwl, minimumHeight, smallLineHeight, spacing, spacingLarge, spacingMedium, systemFont, white)

import Css exposing (..)
import Css.Global exposing (..)


spacing =
    Css.rem 0.5


spacingMedium =
    Css.rem 0.75


spacingLarge =
    Css.rem 1


baseLineHeight =
    num 1.5


smallLineHeight =
    num 1


minimumHeight =
    Css.rem 1.5


black =
    hex "000"


white =
    hex "fff"


baseTextColor =
    color (hex "101010")


border1px : Color -> Style
border1px color =
    border3 (px 1) solid color


borderColor =
    hex "9f9f9f"


borderRadius =
    px 2


borderColorDisabled =
    hex "8f8f8f"


borderColorRequired =
    hex "1f1f1f"


borderColorEmphasized =
    hex "0f0f0f"


baseTextSize =
    px 18


systemFont =
    fontFamilies [ qt "system" ]


sharedHoverFocusStyle =
    backgroundColor (hex "cfcfcf")


interactable =
    batch
        [ cursor pointer
        , property "transition" "background .2s"
        , focus
            [ important (outline none)
            , sharedHoverFocusStyle
            ]
        , hover
            [ sharedHoverFocusStyle ]
        , active
            [ backgroundColor (hex "a0a0a0") ]
        ]


lobotomizedOwl : List Style -> Style
lobotomizedOwl snippet =
    batch
        [ children
            [ everything
                [ adjacentSiblings
                    [ everything
                        snippet
                    ]
                ]
            ]
        ]
