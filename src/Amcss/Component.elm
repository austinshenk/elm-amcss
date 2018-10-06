module Amcss.Component exposing
    ( attribute
    , attributeString
    , component
    , componentToAttribute
    , componentToHtml
    , defaultAttribute
    , defaultProperty
    , element
    , property
    , propertyToAttribute
    )

import Amcss.Types exposing (Component, Property)
import Html.Styled as Html
import Html.Styled.Attributes


attributeString : String
attributeString =
    "a-m"


component : String -> Component
component =
    Amcss.Types.Component


element : String -> Component
element =
    Amcss.Types.Element


property : Component -> String -> String -> Property
property =
    Amcss.Types.Property


defaultProperty : Component -> String -> String -> Property
defaultProperty =
    Amcss.Types.DefaultProperty


attribute : Component -> String -> String -> Property
attribute =
    Amcss.Types.Attribute


defaultAttribute : Component -> String -> String -> Property
defaultAttribute =
    Amcss.Types.DefaultAttribute


componentToHtml : Component -> (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentToHtml comp elem properties attributes =
    let
        componentAsAttribute =
            case comp of
                Amcss.Types.Component n ->
                    [ Html.Styled.Attributes.attribute attributeString n ]

                Amcss.Types.Element _ ->
                    []

        propertiesAsAttributes =
            List.map propertyToAttribute properties
    in
    elem (componentAsAttribute ++ propertiesAsAttributes ++ attributes)


propertyToAttribute : Property -> Html.Attribute msg
propertyToAttribute prop =
    let
        ( name, value ) =
            case prop of
                Amcss.Types.Property _ n v ->
                    ( "a-" ++ n, v )

                Amcss.Types.DefaultProperty _ n v ->
                    ( "a-" ++ n, v )

                Amcss.Types.Attribute _ n v ->
                    ( n, v )

                Amcss.Types.DefaultAttribute _ n v ->
                    ( n, v )
    in
    Html.Styled.Attributes.attribute name value


componentToAttribute : Component -> Html.Attribute msg
componentToAttribute comp =
    let
        name =
            case comp of
                Amcss.Types.Component n ->
                    n

                Amcss.Types.Element _ ->
                    ""
    in
    Html.Styled.Attributes.attribute attributeString name
