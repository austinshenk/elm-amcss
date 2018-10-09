module Amcss.Component.Flyover.Modal exposing
    ( alignCenter
    , alignLeft
    , alignRight
    , css
    , enterBottom
    , enterLeft
    , enterRight
    , enterTop
    )

import Amcss.Component
import Amcss.Component.Flyover as Flyover
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Component.componentToSelector component
        [ backgroundColor StyleGuide.white
        , maxWidth (px 1000)
        , width (vw 100)
        , position absolute
        , top zero
        , Css.property "transition" "transform .2s"
        , overflowX hidden
        ]
    , Amcss.Component.propertyToSelector [ alignLeft ]
        [ left zero ]
    , Amcss.Component.propertyToSelector [ alignCenter ]
        [ left (pct 50) ]
    , Amcss.Component.propertyToSelector [ alignRight ]
        [ right zero ]
    , Amcss.Component.propertyToSelector [ Flyover.invisible ]
        [ children
            [ Amcss.Component.propertyToSelector [ enterTop ]
                [ transform (translateY (pct -100)) ]
            , Amcss.Component.propertyToSelector [ enterBottom ]
                [ transform (translateY (pct 100)) ]
            , Amcss.Component.propertyToSelector [ enterLeft ]
                [ transform (translateX (pct -100)) ]
            , Amcss.Component.propertyToSelector [ enterRight ]
                [ transform (translateX (pct 100)) ]
            , Amcss.Component.propertyToSelector [ alignCenter, enterTop ]
                [ transform (translate2 (pct -50) (pct -100)) ]
            , Amcss.Component.propertyToSelector [ alignCenter, enterBottom ]
                [ transform (translate2 (pct -50) (pct 100)) ]
            , each
                [ Amcss.Component.propertyToSelector [ alignCenter, enterRight ]
                , Amcss.Component.propertyToSelector [ alignCenter, enterLeft ]
                , Amcss.Component.propertyToSelector [ alignLeft, enterRight ]
                , Amcss.Component.propertyToSelector [ alignRight, enterLeft ]
                ]
                [ transform none ]
            ]
        ]
    , Amcss.Component.propertyToSelector [ Flyover.isvisible ]
        [ children
            [ each
                [ Amcss.Component.propertyToSelector [ alignLeft ]
                , Amcss.Component.propertyToSelector [ alignRight ]
                ]
                [ transform none ]
            , Amcss.Component.propertyToSelector [ alignCenter ]
                [ transform (translate2 (pct -50) zero) ]
            ]
        ]
    ]


component =
    Amcss.Component.component "m"


align =
    Amcss.Component.property component "a"


enter =
    Amcss.Component.property component "e"


alignLeft =
    align "0"


alignCenter =
    align "1"


alignRight =
    align "2"


enterTop =
    enter "0"


enterRight =
    enter "1"


enterBottom =
    enter "2"


enterLeft =
    enter "3"
