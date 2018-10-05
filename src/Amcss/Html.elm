module Amcss.Html exposing (attribute, component)

import Amcss exposing (..)
import Amcss.Types
import Html.Styled as Html
import Html.Styled.Attributes


attribute : Amcss.Types.Property -> Html.Attribute msg
attribute =
    Amcss.propertyToAttribute


component : Amcss.Types.Component -> Html.Attribute msg
component comp =
    let
        name =
            case comp of
                Amcss.Types.Component n ->
                    n

                Amcss.Types.Element _ ->
                    ""
    in
    Html.Styled.Attributes.attribute Amcss.attributeString name
