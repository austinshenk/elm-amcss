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

import Amcss exposing (component, defaultProperty, property)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Css.component component
        [ displayFlex
        , StyleGuide.lobotomizedOwl
            [ margin4 StyleGuide.spacing zero zero zero ]
        ]
    , Amcss.Css.selector [ directionColumn ]
        [ flexDirection column ]
    , Amcss.Css.selector [ directionRow ]
        [ flexDirection row
        , StyleGuide.lobotomizedOwl
            [ margin4 zero zero zero StyleGuide.spacing ]
        ]
    , Amcss.Css.selector [ justifyContentStart ]
        [ Css.justifyContent flexStart ]
    , Amcss.Css.selector [ justifyContentCenter ]
        [ Css.justifyContent center ]
    , Amcss.Css.selector [ justifyContentEnd ]
        [ Css.justifyContent flexEnd ]
    , Amcss.Css.selector [ justifyContentSpaceAround ]
        [ Css.justifyContent spaceAround ]
    , Amcss.Css.selector [ justifyContentSpaceBetween ]
        [ Css.justifyContent spaceBetween ]
    , Amcss.Css.selector [ alignItemsStretch ]
        [ Css.alignItems stretch ]
    , Amcss.Css.selector [ alignItemsStart ]
        [ Css.alignItems flexStart ]
    , Amcss.Css.selector [ alignItemsCenter ]
        [ Css.alignItems center ]
    , Amcss.Css.selector [ alignItemsEnd ]
        [ Css.alignItems flexEnd ]
    , Amcss.Css.selector [ alignItemsBaseline ]
        [ Css.alignItems baseline ]
    , Amcss.Css.selector [ alignContentStretch ]
        [ Css.property "align-content" "stretch" ]
    , Amcss.Css.selector [ alignContentStart ]
        [ Css.property "align-content" "start" ]
    , Amcss.Css.selector [ alignContentCenter ]
        [ Css.property "align-content" "center" ]
    , Amcss.Css.selector [ alignContentEnd ]
        [ Css.property "align-content" "end" ]
    , Amcss.Css.selector [ alignContentSpaceAround ]
        [ Css.property "align-content" "space-around" ]
    , Amcss.Css.selector [ alignContentSpaceBetween ]
        [ Css.property "align-content" "space-between" ]
    , Amcss.Css.selector [ wrapEnable ]
        [ flexWrap Css.wrap ]
    , Amcss.Css.selector [ wrapDisable ]
        [ flexWrap noWrap ]
    , Amcss.Css.selector [ wrapReverse ]
        [ flexWrap Css.wrapReverse ]
    , Amcss.Css.selector [ spacingDisable ]
        [ StyleGuide.lobotomizedOwl [ margin zero ] ]
    , Amcss.Css.selector [ homogenousEnable, directionRow ]
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
    , Amcss.Css.selector [ homogenousEnable, directionColumn ]
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


component =
    Amcss.component "g"


alignContent =
    Amcss.property component "a"


alignItems =
    Amcss.property component "i"


direction =
    Amcss.property component "d"


justifyContent =
    Amcss.property component "j"


spacing =
    Amcss.property component "s"


wrap =
    Amcss.property component "w"


homogenous =
    Amcss.property component "h"


alignContentStretch =
    defaultProperty component "a" "1"


alignContentStart =
    alignContent "2"


alignContentCenter =
    alignContent "3"


alignContentEnd =
    alignContent "4"


alignContentSpaceAround =
    alignContent "5"


alignContentSpaceBetween =
    alignContent "6"


alignItemsStretch =
    defaultProperty component "i" "1"


alignItemsStart =
    alignItems "2"


alignItemsCenter =
    alignItems "3"


alignItemsEnd =
    alignItems "4"


alignItemsBaseline =
    alignItems "5"


directionColumn =
    defaultProperty component "d" "1"


directionRow =
    direction "2"


justifyContentStart =
    defaultProperty component "j" "1"


justifyContentCenter =
    justifyContent "2"


justifyContentEnd =
    justifyContent "3"


justifyContentSpaceAround =
    justifyContent "4"


justifyContentSpaceBetween =
    justifyContent "5"


spacingEnable =
    defaultProperty component "s" "1"


spacingDisable =
    spacing "2"


wrapEnable =
    defaultProperty component "w" "1"


wrapDisable =
    wrap "2"


wrapReverse =
    wrap "-1"


homogenousDisable =
    defaultProperty component "h" "1"


homogenousEnable =
    homogenous "2"
