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
    , link
    , link2
    , link3
    , property
    , propertyToAttribute
    )

import Amcss.Types
import Html.Styled as Html
import Html.Styled.Attributes


attributeString : String
attributeString =
    "a-m"


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


componentToElement : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
componentToElement elem properties attributes =
    let
        propertiesAsAttributes =
            List.map propertyToAttribute properties
    in
    elem (propertiesAsAttributes ++ attributes)


propertyToAttribute : Amcss.Types.Property -> Html.Attribute msg
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


button : List (Html.Html msg) -> Html.Html msg
button =
    button2 []


button2 : List Property -> List (Html.Html msg) -> Html.Html msg
button2 properties =
    button3 properties []


button3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button3 =
    componentToElement Html.button


link : List (Html.Html msg) -> Html.Html msg
link =
    link2 []


link2 : List Property -> List (Html.Html msg) -> Html.Html msg
link2 properties =
    link3 properties []


link3 : List Property -> List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
link3 =
    componentToElement Html.a
