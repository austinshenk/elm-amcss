module Amcss.Component exposing
    ( attribute
    , attributeString
    , component
    , componentToAttribute
    , componentToHtml
    , componentToSelector
    , defaultAttribute
    , defaultProperty
    , element
    , property
    , propertyToAttribute
    , propertyToSelector
    , propertyToSelectorNotExist
    )

import Amcss.Types exposing (Component, Property)
import Css exposing (..)
import Css.Global exposing (..)
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


componentToSelector : Amcss.Types.Component -> List Style -> Snippet
componentToSelector comp =
    Css.Global.selector (componentToSelectorString comp)


componentToSelectorString : Amcss.Types.Component -> String
componentToSelectorString comp =
    case comp of
        Amcss.Types.Component name ->
            "[" ++ attributeString ++ "='" ++ name ++ "']"

        Amcss.Types.Element elem ->
            elem ++ propertyExists ("[" ++ attributeString ++ "]") False


propertyToSelector : List Amcss.Types.Property -> List Style -> Snippet
propertyToSelector properties =
    propertyListToSelector properties True


propertyToSelectorNotExist : List Amcss.Types.Property -> List Style -> Snippet
propertyToSelectorNotExist properties =
    propertyListToSelector properties False


propertyListToSelector : List Amcss.Types.Property -> Bool -> List Style -> Snippet
propertyListToSelector properties exists =
    case List.head properties of
        Nothing ->
            Css.Global.selector ""

        Just prop ->
            let
                propertyListString =
                    List.foldl (\p stringSoFar -> stringSoFar ++ propertyToSelectorString p) "" properties
            in
            attributeSelector prop propertyListString exists


propertyToSelectorString : Amcss.Types.Property -> String
propertyToSelectorString prop =
    let
        propertyString =
            case prop of
                Amcss.Types.Property _ name value ->
                    "a-" ++ name ++ "='" ++ value ++ "'"

                Amcss.Types.DefaultProperty _ name value ->
                    "a-" ++ name ++ "='" ++ value ++ "'"

                Amcss.Types.Attribute _ name value ->
                    name ++ "='" ++ value ++ "'"

                Amcss.Types.DefaultAttribute _ name value ->
                    name ++ "='" ++ value ++ "'"
    in
    "[" ++ propertyString ++ "]"


attributeSelector : Amcss.Types.Property -> String -> Bool -> List Style -> Snippet
attributeSelector prop propertySelectorString exists =
    let
        selectorForModule componentSelectorString =
            Css.Global.selector (componentSelectorString ++ propertyExists propertySelectorString exists)

        selectors =
            case prop of
                Amcss.Types.Property m _ _ ->
                    [ selectorForModule (componentToSelectorString m) ]

                Amcss.Types.DefaultProperty m _ _ ->
                    let
                        componentSelectorString =
                            componentToSelectorString m
                    in
                    [ Css.Global.selector componentSelectorString
                    , selectorForModule componentSelectorString
                    ]

                Amcss.Types.Attribute m _ _ ->
                    [ selectorForModule (componentToSelectorString m) ]

                Amcss.Types.DefaultAttribute m _ _ ->
                    let
                        componentSelectorString =
                            componentToSelectorString m
                    in
                    [ Css.Global.selector componentSelectorString
                    , selectorForModule componentSelectorString
                    ]
    in
    each selectors


propertyExists : String -> Bool -> String
propertyExists string exists =
    case exists of
        False ->
            ":not(" ++ string ++ ")"

        True ->
            string
