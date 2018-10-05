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
    , group
    , group2
    , group3
    , group4
    , link
    , link2
    , link3
    , property
    )

import Amcss.Component
import Amcss.Types
import Html.Styled as Html
import Html.Styled.Attributes


attributeString : String
attributeString =
    Amcss.Component.attributeString


type alias Component =
    Amcss.Types.Component


component : String -> Component
component =
    Amcss.Component.component


element : String -> Component
element =
    Amcss.Component.element


type alias Property =
    Amcss.Types.Property


property : Component -> String -> String -> Property
property =
    Amcss.Component.property


defaultProperty : Component -> String -> String -> Property
defaultProperty =
    Amcss.Component.defaultProperty


attribute : Component -> String -> String -> Property
attribute =
    Amcss.Component.attribute


defaultAttribute : Component -> String -> String -> Property
defaultAttribute =
    Amcss.Component.defaultAttribute


componentToElement : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> Maybe Component -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentToElement =
    Amcss.Component.componentToElement


button : List (Html.Html msg) -> Html.Html msg
button =
    button2 []


button2 : List Property -> List (Html.Html msg) -> Html.Html msg
button2 properties =
    button3 properties []


button3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button3 =
    Amcss.Component.componentToElement Html.button Nothing


link : List (Html.Html msg) -> Html.Html msg
link =
    link2 []


link2 : List Property -> List (Html.Html msg) -> Html.Html msg
link2 properties =
    link3 properties []


link3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
link3 =
    Amcss.Component.componentToElement Html.a Nothing


group : List (Html.Html msg) -> Html.Html msg
group body =
    group2 Html.div body


group2 : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List (Html.Html msg) -> Html.Html msg
group2 elem body =
    group3 elem [] body


group3 : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Html msg) -> Html.Html msg
group3 elem properties body =
    group4 elem properties [] body


group4 : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
group4 elem properties attributes body =
    Amcss.Component.componentToElement elem Nothing properties attributes body
