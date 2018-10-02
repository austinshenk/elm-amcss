module Amcss.Component.Window exposing
    ( component
    , css
    , overflowHidden
    , overflowScrollable
    )

import Amcss exposing (component, defaultProperty, property)
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
    Amcss.component "w"


overflowHidden =
    Amcss.property component "o" "0"


overflowScrollable =
    defaultProperty component "o" "1"
