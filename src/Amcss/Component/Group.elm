module Amcss.Component.Group exposing
    ( alignContentCenter
    , alignContentEnd
    , alignContentSpaceAround
    , alignContentSpaceBetween
    , alignContentStart
    , alignContentStretch
    , alignItemsBaseline
    , alignItemsCenter
    , alignItemsEnd
    , alignItemsStart
    , alignItemsStretch
    , component
    , css
    , directionColumn
    , directionRow
    , homogenousDisable
    , homogenousEnable
    , justifyContentCenter
    , justifyContentEnd
    , justifyContentSpaceAround
    , justifyContentSpaceBetween
    , justifyContentStart
    , spacingDisable
    , spacingEnable
    , wrapDisable
    , wrapEnable
    , wrapReverse
    )

import Amcss.Component
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Types exposing (Component, Property)
import Css exposing (baseline, borderBottomLeftRadius, borderBottomRightRadius, borderTopLeftRadius, borderTopRightRadius, center, column, displayFlex, flexDirection, flexEnd, flexStart, flexWrap, important, margin, margin4, marginBottom, marginLeft, marginRight, marginTop, noWrap, row, spaceAround, spaceBetween, stretch, zero)
import Css.Global exposing (Snippet, children)


css : List Snippet
css =
    [ Amcss.Component.componentToSelector component
        [ displayFlex
        , StyleGuide.lobotomizedOwl
            [ margin4 StyleGuide.spacing zero zero zero ]
        ]
    , Amcss.Component.propertyToSelector [ directionColumn ]
        [ flexDirection column ]
    , Amcss.Component.propertyToSelector [ directionRow ]
        [ flexDirection row
        , StyleGuide.lobotomizedOwl
            [ margin4 zero zero zero StyleGuide.spacing ]
        ]
    , Amcss.Component.propertyToSelector [ justifyContentStart ]
        [ Css.justifyContent flexStart ]
    , Amcss.Component.propertyToSelector [ justifyContentCenter ]
        [ Css.justifyContent center ]
    , Amcss.Component.propertyToSelector [ justifyContentEnd ]
        [ Css.justifyContent flexEnd ]
    , Amcss.Component.propertyToSelector [ justifyContentSpaceAround ]
        [ Css.justifyContent spaceAround ]
    , Amcss.Component.propertyToSelector [ justifyContentSpaceBetween ]
        [ Css.justifyContent spaceBetween ]
    , Amcss.Component.propertyToSelector [ alignItemsStretch ]
        [ Css.alignItems stretch ]
    , Amcss.Component.propertyToSelector [ alignItemsStart ]
        [ Css.alignItems flexStart ]
    , Amcss.Component.propertyToSelector [ alignItemsCenter ]
        [ Css.alignItems center ]
    , Amcss.Component.propertyToSelector [ alignItemsEnd ]
        [ Css.alignItems flexEnd ]
    , Amcss.Component.propertyToSelector [ alignItemsBaseline ]
        [ Css.alignItems baseline ]
    , Amcss.Component.propertyToSelector [ alignContentStretch ]
        [ Css.property "align-content" "stretch" ]
    , Amcss.Component.propertyToSelector [ alignContentStart ]
        [ Css.property "align-content" "start" ]
    , Amcss.Component.propertyToSelector [ alignContentCenter ]
        [ Css.property "align-content" "center" ]
    , Amcss.Component.propertyToSelector [ alignContentEnd ]
        [ Css.property "align-content" "end" ]
    , Amcss.Component.propertyToSelector [ alignContentSpaceAround ]
        [ Css.property "align-content" "space-around" ]
    , Amcss.Component.propertyToSelector [ alignContentSpaceBetween ]
        [ Css.property "align-content" "space-between" ]
    , Amcss.Component.propertyToSelector [ wrapEnable ]
        [ flexWrap Css.wrap ]
    , Amcss.Component.propertyToSelector [ wrapDisable ]
        [ flexWrap noWrap ]
    , Amcss.Component.propertyToSelector [ wrapReverse ]
        [ flexWrap Css.wrapReverse ]
    , Amcss.Component.propertyToSelector [ spacingDisable ]
        [ StyleGuide.lobotomizedOwl [ margin zero ] ]
    , Amcss.Component.propertyToSelector [ homogenousEnable, directionRow ]
        [ StyleGuide.lobotomizedOwl
            [ Css.property "border-left" "none !important"
            , important (borderTopLeftRadius zero)
            , important (borderBottomLeftRadius zero)
            , important (marginLeft zero)
            ]
        , children
            [ Css.Global.selector "*:not(:last-child)"
                [ Css.property "border-right" "none !important"
                , important (borderTopRightRadius zero)
                , important (borderBottomRightRadius zero)
                , important (marginRight zero)
                ]
            ]
        ]
    , Amcss.Component.propertyToSelector [ homogenousEnable, directionColumn ]
        [ StyleGuide.lobotomizedOwl
            [ Css.property "border-top" "none !important"
            , important (borderTopLeftRadius zero)
            , important (borderTopRightRadius zero)
            , important (marginTop zero)
            ]
        , children
            [ Css.Global.selector "*:not(:last-child)"
                [ Css.property "border-bottom" "none !important"
                , important (borderBottomLeftRadius zero)
                , important (borderBottomRightRadius zero)
                , important (marginBottom zero)
                ]
            ]
        ]
    ]


component : Component
component =
    Amcss.Component.component "g"


alignContent : String -> Property
alignContent =
    Amcss.Component.property component "a"


alignItems : String -> Property
alignItems =
    Amcss.Component.property component "i"


direction : String -> Property
direction =
    Amcss.Component.property component "d"


justifyContent : String -> Property
justifyContent =
    Amcss.Component.property component "j"


spacing : String -> Property
spacing =
    Amcss.Component.property component "s"


wrap : String -> Property
wrap =
    Amcss.Component.property component "w"


homogenous : String -> Property
homogenous =
    Amcss.Component.property component "h"


alignContentStretch : Property
alignContentStretch =
    Amcss.Component.defaultProperty component "a" "1"


alignContentStart : Property
alignContentStart =
    alignContent "2"


alignContentCenter : Property
alignContentCenter =
    alignContent "3"


alignContentEnd : Property
alignContentEnd =
    alignContent "4"


alignContentSpaceAround : Property
alignContentSpaceAround =
    alignContent "5"


alignContentSpaceBetween : Property
alignContentSpaceBetween =
    alignContent "6"


alignItemsStretch : Property
alignItemsStretch =
    Amcss.Component.defaultProperty component "i" "1"


alignItemsStart : Property
alignItemsStart =
    alignItems "2"


alignItemsCenter : Property
alignItemsCenter =
    alignItems "3"


alignItemsEnd : Property
alignItemsEnd =
    alignItems "4"


alignItemsBaseline : Property
alignItemsBaseline =
    alignItems "5"


directionColumn : Property
directionColumn =
    Amcss.Component.defaultProperty component "d" "1"


directionRow : Property
directionRow =
    direction "2"


justifyContentStart : Property
justifyContentStart =
    Amcss.Component.defaultProperty component "j" "1"


justifyContentCenter : Property
justifyContentCenter =
    justifyContent "2"


justifyContentEnd : Property
justifyContentEnd =
    justifyContent "3"


justifyContentSpaceAround : Property
justifyContentSpaceAround =
    justifyContent "4"


justifyContentSpaceBetween : Property
justifyContentSpaceBetween =
    justifyContent "5"


spacingEnable : Property
spacingEnable =
    Amcss.Component.defaultProperty component "s" "1"


spacingDisable : Property
spacingDisable =
    spacing "2"


wrapEnable : Property
wrapEnable =
    Amcss.Component.defaultProperty component "w" "1"


wrapDisable : Property
wrapDisable =
    wrap "2"


wrapReverse : Property
wrapReverse =
    wrap "-1"


homogenousDisable : Property
homogenousDisable =
    Amcss.Component.defaultProperty component "h" "1"


homogenousEnable : Property
homogenousEnable =
    homogenous "2"
