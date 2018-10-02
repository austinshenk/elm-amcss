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

import Amcss
import Amcss.Component.Flyover as Flyover
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Css.component component
        [ backgroundColor StyleGuide.white
        , maxWidth (px 1000)
        , width (vw 100)
        , position absolute
        , top zero
        , Css.property "transition" "transform .2s"
        , overflowX hidden
        ]
    , Amcss.Css.selector [ alignLeft ]
        [ left zero ]
    , Amcss.Css.selector [ alignCenter ]
        [ left (pct 50) ]
    , Amcss.Css.selector [ alignRight ]
        [ right zero ]
    , Amcss.Css.selector [ Flyover.invisible ]
        [ children
            [ Amcss.Css.selector [ enterTop ]
                [ transform (translateY (pct -100)) ]
            , Amcss.Css.selector [ enterBottom ]
                [ transform (translateY (pct 100)) ]
            , Amcss.Css.selector [ enterLeft ]
                [ transform (translateX (pct -100)) ]
            , Amcss.Css.selector [ enterRight ]
                [ transform (translateX (pct 100)) ]
            , Amcss.Css.selector [ alignCenter, enterTop ]
                [ transform (translate2 (pct -50) (pct -100)) ]
            , Amcss.Css.selector [ alignCenter, enterBottom ]
                [ transform (translate2 (pct -50) (pct 100)) ]
            , each
                [ Amcss.Css.selector [ alignCenter, enterRight ]
                , Amcss.Css.selector [ alignCenter, enterLeft ]
                , Amcss.Css.selector [ alignLeft, enterRight ]
                , Amcss.Css.selector [ alignRight, enterLeft ]
                ]
                [ transform none ]
            ]
        ]
    , Amcss.Css.selector [ Flyover.isvisible ]
        [ children
            [ each
                [ Amcss.Css.selector [ alignLeft ]
                , Amcss.Css.selector [ alignRight ]
                ]
                [ transform none ]
            , Amcss.Css.selector [ alignCenter ]
                [ transform (translate2 (pct -50) zero) ]
            ]
        ]
    ]


component =
    Amcss.component "m"


align =
    Amcss.property component "a"


enter =
    Amcss.property component "e"


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
