module Amcss.Component.Window exposing
    ( component
    , css
    , overflowHidden
    , overflowScrollable
    )

import Amcss.Component
import Amcss.Types exposing (Component, Property)
import Css exposing (auto, height, hidden, overflow, vh, vw, width)
import Css.Global exposing (Snippet)


css : List Snippet
css =
    [ Amcss.Component.componentToSelector component
        [ height (vh 100)
        , width (vw 100)
        ]
    , Amcss.Component.propertyToSelector [ overflowHidden ]
        [ overflow hidden ]
    , Amcss.Component.propertyToSelector [ overflowScrollable ]
        [ overflow auto ]
    ]


component : Component
component =
    Amcss.Component.component "w"


overflowHidden : Property
overflowHidden =
    Amcss.Component.property component "o" "0"


overflowScrollable : Property
overflowScrollable =
    Amcss.Component.defaultProperty component "o" "1"
