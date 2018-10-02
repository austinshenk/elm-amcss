module Amcss.Css.Normalize exposing (css)

{-| This library is mostly a direct port of [normalize.css](https://github.com/necolas/normalize.css).
Compile it with your elm-css code to have easier cross-browser styling experience.


# Normalizing CSS Stylesheet

@docs css


# Css Snippets

@docs snippets

-}

import Css exposing (..)
import Css.Global exposing (..)


{-| The snippets used to generate the normalizing stylesheet. Use this if you want to append
these to your own style sheet. This is useful if you prefer to use inline styles over
generator a stylesheet with the [elm-css preprocessor](https://www.npmjs.com/package/elm-css)

    import Css exposing (..)
    import Css.Elements exposing (..)
    import Css.Namespace exposing (namespace)
    import Css.Normalize

    css : Css.Stylesheet
    css =
        (Css.stylesheet << namespace "my-styles") <|
            List.append
                Css.Normalize.snippets
                [ everything
                    [ boxSizing borderBox ]
                ]

-}
css : List Snippet
css =
    [ html
        [ lineHeight (num 1.15)
        , property "-ms-text-size-adjust" "100%"
        , property "-webkit-text-size-adjust" "100%"
        ]
    , body [ margin zero ]
    , each [ article, aside, footer, header, nav, section ]
        [ display block ]
    , h1
        [ fontSize (Css.em 2)
        , margin2 (Css.em 0.67) zero
        ]
    , each [ selector "figcaption", selector "figure", main_ ] [ display block ]
    , selector "figure" [ margin2 (Css.em 1) (px 40) ]
    , hr
        [ boxSizing contentBox
        , height zero
        , overflow visible
        ]
    , a
        [ backgroundColor transparent
        , property "-webkit-text-decoration-skip" "objects"
        ]
    , selector "abbr[title]"
        [ property "border-bottom" "none"
        , textDecoration underline
        , textDecoration2 underline dotted
        ]
    , each [ selector "b", strong ] [ fontWeight inherit ]
    , each [ selector "b", strong ] [ fontWeight bolder ]
    , each [ Css.Global.pre, Css.Global.code, selector "kbd", selector "samp" ]
        [ fontFamilies [ "monospace", "monospace" ]
        , fontSize (Css.em 1)
        ]
    , selector "dfn" [ fontStyle italic ]
    , selector "mark"
        [ backgroundColor (hex "ff0")
        , color (hex "000")
        ]
    , Css.Global.small [ fontSize (pct 80) ]
    , each [ selector "sub", selector "sup" ]
        [ fontSize (pct 75)
        , lineHeight zero
        , position relative
        , verticalAlign baseline
        ]
    , selector "sub" [ bottom (Css.em -0.25) ]
    , selector "sup" [ top (Css.em -0.5) ]
    , each [ audio, video ] [ display inlineBlock ]
    , selector "audio:not([controls])"
        [ display none
        , height zero
        ]
    , img [ borderStyle none ]
    , selector "svg:not(:root)" [ overflow hidden ]
    , each [ button, input, optgroup, select, textarea ]
        [ fontFamilies [ "sans-serif" ]
        , fontSize (pct 100)
        , lineHeight (num 1.15)
        , margin zero
        ]
    , each [ button, input ] [ overflow visible ]
    , each [ button, select ] [ property "text-transform" "none" ]
    , each
        [ button
        , selector "html [type='button']"
        , selector "[type='reset']"
        , selector "[type='submit']"
        ]
        [ property "-webkit-appearance" "button" ]
    , each
        [ selector "button::-moz-focus-inner"
        , selector "[type='button']::-moz-focus-inner"
        , selector "[type='reset']::-moz-focus-inner"
        , selector "[type='submit']::-moz-focus-inner"
        ]
        [ borderStyle none
        , padding zero
        ]
    , each
        [ selector "button::-moz-focusring"
        , selector "[type='button']::-moz-focusring"
        , selector "[type='reset']::-moz-focusring"
        , selector "[type='submit']::-moz-focusring"
        ]
        [ property "outline" "1px dotted ButtonText" ]
    , fieldset
        [ padding3 (Css.em 0.35) (Css.em 0.75) (Css.em 0.625) ]
    , legend
        [ boxSizing borderBox
        , color inherit
        , display Css.table
        , maxWidth (pct 100)
        , padding zero
        , property "white-space" "normal"
        ]
    , Css.Global.progress
        [ display inlineBlock
        , verticalAlign baseline
        ]
    , textarea [ overflow auto ]
    , each
        [ selector "[type='checkbox']"
        , selector "[type='radio']"
        ]
        [ boxSizing borderBox
        , padding zero
        ]
    , each
        [ selector "[type='number']::-webkit-inner-spin-button"
        , selector "[type='number']::-webkit-outer-spin-button"
        ]
        [ height auto ]
    , selector "[type='search']"
        [ property "-webkit-appearance" "textfield"
        , outlineOffset (px -2)
        ]
    , each
        [ selector "[type='search']::-webkit-search-cancel-button"
        , selector "[type='search']::-webkit-search-decoration"
        ]
        [ property "-webkit-appearance" "none" ]
    , selector "::-webkit-file-upload-button"
        [ property "-webkit-appearance" "button"
        , property "font" "inherit"
        ]
    , each [ selector "details", selector "menu" ] [ display block ]
    , selector "summary" [ property "display" "list-item" ]
    , canvas [ display inlineBlock ]
    , selector "template" [ display none ]
    , selector "[hidden]" [ display none ]
    ]
