module Amcss.Component.Popup.Dropdown exposing (css, dropdown, dropdownRight)

import Amcss exposing (Component, component)
import Amcss.Component.Popup as Popup exposing (Align(..), Anchor(..), Model, Msg(..), Position(..), Properties)
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Html
import Css exposing (..)
import Css.Global exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)


css =
    [ Amcss.Css.component component
        [ borderRadius StyleGuide.borderRadius
        , border3 (px 1) solid StyleGuide.black
        , backgroundColor StyleGuide.white
        , padding2 StyleGuide.spacing zero
        , position relative
        ]
    , Amcss.Css.selector [ Popup.positionBottom ]
        [ children
            [ Amcss.Css.component component
                [ top StyleGuide.spacing ]
            ]
        ]
    ]


component : Component
component =
    Amcss.component "d"


view : Html a -> Html a
view html =
    Html.div [ Amcss.Html.component component ] [ html ]


dropdownFull_ : Align -> Anchor -> (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model -> (Msg -> a) -> String -> List (Attribute Msg) -> List (Html Msg) -> Html Msg -> Html a
dropdownFull_ align anchor element model messageMapping id elementAttributes elementHtml popupHtml =
    let
        togglePopupMsg =
            if model.id == id then
                Hide model.popupId id

            else
                Show model.popupId id (Just (view popupHtml)) (Just (Properties align model.defaultProperties.position anchor model.defaultProperties.animatePosition))

        fullAttribute =
            elementAttributes
                ++ [ Html.Styled.Attributes.attribute "id" id
                   , onClick togglePopupMsg
                   ]

        fullBody =
            if model.id == id then
                elementHtml ++ [ Popup.view model id ]

            else
                elementHtml ++ [ Popup.view { model | html = Nothing } id ]
    in
    Html.map messageMapping
        (element fullAttribute fullBody)


dropdown : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model -> (Msg -> a) -> String -> List (Attribute Msg) -> List (Html Msg) -> Html Msg -> Html a
dropdown =
    dropdownFull_ LeftAlign LeftAnchor


dropdownRight : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model -> (Msg -> a) -> String -> List (Attribute Msg) -> List (Html Msg) -> Html Msg -> Html a
dropdownRight =
    dropdownFull_ RightAlign RightAnchor
