module Amcss.Html exposing (attribute, component, componentToElement)

import Amcss exposing (..)
import Amcss.Types
import Html.Styled as Html
import Html.Styled.Attributes


attribute : Amcss.Types.Property -> Html.Attribute msg
attribute prop =
    let
        value =
            case prop of
                Amcss.Types.Property _ _ v ->
                    v

                Amcss.Types.DefaultProperty _ _ v ->
                    v

                Amcss.Types.Attribute _ _ v ->
                    v

                Amcss.Types.DefaultAttribute _ _ v ->
                    v
    in
    Html.Styled.Attributes.attribute (propertyToAttributeString prop) value


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


componentToElement : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentToElement element properties attributes =
    let
        propertiesAsAttributes =
            List.map attribute properties
    in
    element (propertiesAsAttributes ++ attributes)
