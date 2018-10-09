module Amcss.Component.Flyover.Backdrop exposing (css)

import Amcss.Component
import Amcss.Component.Flyover as Flyover
import Amcss.Css.StyleGuide as StyleGuide
import Css exposing (..)
import Css.Global exposing (..)


css =
    [ Amcss.Component.componentToSelector component
        [ width (pct 100)
        , height (pct 100)
        , backgroundColor StyleGuide.black
        , opacity zero
        , property "transition" "opacity .2s"
        ]
    , Amcss.Component.propertyToSelector [ Flyover.isvisible ]
        [ children
            [ Amcss.Component.componentToSelector component
                [ opacity (num 0.5) ]
            ]
        ]
    ]


component =
    Amcss.Component.component "b"
