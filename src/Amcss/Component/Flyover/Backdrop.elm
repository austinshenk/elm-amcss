module Amcss.Component.Flyover.Backdrop exposing (css)

import Amcss.Component
import Amcss.Component.Flyover as Flyover
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Css.component component
        [ width (pct 100)
        , height (pct 100)
        , backgroundColor StyleGuide.black
        , opacity zero
        , property "transition" "opacity .2s"
        ]
    , Amcss.Css.selector [ Flyover.isvisible ]
        [ children
            [ Amcss.Css.component component
                [ opacity (num 0.5) ]
            ]
        ]
    ]


component =
    Amcss.Component.component "b"
