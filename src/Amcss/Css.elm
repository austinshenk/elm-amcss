module Amcss.Css exposing (component, selector, selectorNotExist)

import Amcss exposing (..)
import Amcss.Types
import Css exposing (..)
import Css.Global exposing (..)


component : Amcss.Types.Component -> List Style -> Snippet
component comp =
    Css.Global.selector (componentToString comp)


componentToString : Amcss.Types.Component -> String
componentToString comp =
    case comp of
        Amcss.Types.Component name ->
            "[" ++ Amcss.attributeString ++ "='" ++ name ++ "']"

        Amcss.Types.Element element ->
            element ++ propertyExists ("[" ++ Amcss.attributeString ++ "]") False


selector : List Amcss.Types.Property -> List Style -> Snippet
selector properties =
    propertyListToSelector properties True


selectorNotExist : List Amcss.Types.Property -> List Style -> Snippet
selectorNotExist properties =
    propertyListToSelector properties False


propertyListToSelector : List Amcss.Types.Property -> Bool -> List Style -> Snippet
propertyListToSelector properties exists =
    case List.head properties of
        Nothing ->
            Css.Global.selector ""

        Just prop ->
            let
                propertyListString =
                    List.foldl (\p stringSoFar -> stringSoFar ++ propertyToString p) "" properties
            in
            attributeSelector prop propertyListString exists


propertyToString : Amcss.Types.Property -> String
propertyToString prop =
    let
        rightHandValue =
            case prop of
                Amcss.Types.Property _ _ v ->
                    "='" ++ v ++ "'"

                Amcss.Types.DefaultProperty _ _ v ->
                    "='" ++ v ++ "'"

                Amcss.Types.Attribute _ _ v ->
                    "='" ++ v ++ "'"

                Amcss.Types.DefaultAttribute _ _ v ->
                    "='" ++ v ++ "'"
    in
    "[" ++ propertyToAttributeString prop ++ rightHandValue ++ "]"


propertyToAttributeString : Amcss.Types.Property -> String
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


attributeSelector : Amcss.Types.Property -> String -> Bool -> List Style -> Snippet
attributeSelector prop propertySelectorString exists =
    let
        selectorForModule componentSelectorString =
            Css.Global.selector (componentSelectorString ++ propertyExists propertySelectorString exists)

        selectors =
            case prop of
                Amcss.Types.Property m _ _ ->
                    [ selectorForModule (componentToString m) ]

                Amcss.Types.DefaultProperty m _ _ ->
                    [ Css.Global.selector (componentToString m)
                    , selectorForModule (componentToString m)
                    ]

                Amcss.Types.Attribute m _ _ ->
                    [ selectorForModule (componentToString m) ]

                Amcss.Types.DefaultAttribute m _ _ ->
                    [ Css.Global.selector (componentToString m)
                    , selectorForModule (componentToString m)
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
