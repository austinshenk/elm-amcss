module Amcss.Html exposing (attribute, component)

import Amcss.Component
import Amcss.Types
import Html.Styled as Html
import Html.Styled.Attributes


attribute : Amcss.Types.Property -> Html.Attribute msg
attribute =
    Amcss.Component.propertyToAttribute


component : Amcss.Types.Component -> Html.Attribute msg
component =
    Amcss.Component.componentToAttribute
