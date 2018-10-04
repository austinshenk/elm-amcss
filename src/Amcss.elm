module Amcss exposing
    ( Component
    , Property
    , attribute
    , attributeString
    , button
    , button2
    , button3
    , component
    , defaultAttribute
    , defaultProperty
    , element
    , property
    , propertyToAttributeString
    )

import Amcss.Component.Button as Button
import Amcss.Html
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


button : List (Html.Html msg) -> Html.Html msg
button =
    button2 []


button2 : List Property -> List (Html.Html msg) -> Html.Html msg
button2 properties =
    button3 properties []


button3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button3 =
    Amcss.Html.componentToElement Html.button
