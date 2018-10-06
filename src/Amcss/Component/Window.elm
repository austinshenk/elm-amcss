module Amcss.Component.Window exposing
    ( component
    , css
    , overflowHidden
    , overflowScrollable
    )

import Amcss.Component
import Amcss.Css
import Css exposing (..)


css =
    [ Amcss.Css.component component
        [ height (vh 100) ]
    , Amcss.Css.selector [ overflowHidden ]
        [ Css.overflow hidden ]
    , Amcss.Css.selector [ overflowScrollable ]
        [ Css.overflow auto ]
    ]


component =
    Amcss.Component.component "w"


overflowHidden =
    Amcss.Component.property component "o" "0"


overflowScrollable =
    Amcss.Component.defaultProperty component "o" "1"
