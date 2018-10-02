module Amcss.Types exposing (Component(..), Property(..))


type Component
    = Component String
    | Element String


type Property
    = Property Component String String
    | DefaultProperty Component String String
    | Attribute Component String String
    | DefaultAttribute Component String String
