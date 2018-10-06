module Amcss exposing
    ( Component
    , Property
    , attribute
    , attributeString
    , button
    , button2
    , button3
    , component
    , componentToHtml
    , defaultAttribute
    , defaultProperty
    , element
    , group
    , group2
    , group3
    , group4
    , input
    , input2
    , input3
    , link
    , link2
    , link3
    , property
    , select
    , select2
    , select3
    )

import Amcss.Component
import Amcss.Component.Button as Button
import Amcss.Component.Form as Form
import Amcss.Component.Group as Group
import Amcss.Component.Link as Link
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


componentToHtml : Component -> (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentToHtml =
    Amcss.Component.componentToHtml


button : List (Html.Html msg) -> Html.Html msg
button =
    button2 []


button2 : List Property -> List (Html.Html msg) -> Html.Html msg
button2 properties =
    button3 properties []


button3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button3 =
    componentToHtml Button.component Html.button


link : List (Html.Html msg) -> Html.Html msg
link =
    link2 []


link2 : List Property -> List (Html.Html msg) -> Html.Html msg
link2 properties =
    link3 properties []


link3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
link3 =
    componentToHtml Link.component Html.a


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
group4 =
    componentToHtml Group.component


input : List Property -> Html.Html msg
input properties =
    input2 properties []


input2 : List Property -> List (Html.Attribute msg) -> Html.Html msg
input2 properties attributes =
    input3 properties attributes []


input3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
input3 =
    componentToHtml Form.input Html.input


select : List (Html.Html msg) -> Html.Html msg
select =
    select2 []


select2 : List Property -> List (Html.Html msg) -> Html.Html msg
select2 properties =
    select3 properties []


select3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
select3 =
    componentToHtml Form.select Html.select
