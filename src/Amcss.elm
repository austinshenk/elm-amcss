module Amcss exposing
    ( Component
    , Property
    , attribute
    , attributeString
    , component
    , defaultAttribute
    , defaultProperty
    , element
    , property
    , propertyToAttributeString
    )

import Amcss.Types
import Html.Styled as Html


type alias Component =
    Amcss.Types.Component


component : String -> Component
component =
    Amcss.Types.Component


element : String -> Component
element =
    Amcss.Types.Element


type alias Property =
    Amcss.Types.Property


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


attributeString : String
attributeString =
    "a-m"


propertyToAttributeString : Property -> String
propertyToAttributeString prop =
    case prop of
        Amcss.Types.Property _ name _ ->
            "a-" ++ name

        Amcss.Types.DefaultProperty _ name _ ->
            "a-" ++ name

        Amcss.Types.Attribute _ name _ ->
            name

        Amcss.Types.DefaultAttribute _ name _ ->
            name
