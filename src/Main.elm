module Main exposing (main)

import Amcss
import Amcss.Component.Button as Button
import Amcss.Component.Flyover as Flyover
import Amcss.Component.Flyover.Backdrop as Backdrop
import Amcss.Component.Flyover.Modal as Modal
import Amcss.Component.Group as Group
import Amcss.Component.Link as Link
import Amcss.Component.Popup as Popup
import Amcss.Component.Popup.Dropdown as Dropdown exposing (dropdown, dropdownRight)
import Amcss.Component.Popup.Tooltip as Tooltip exposing (tooltip, tooltipBottom, tooltipBottomLeft, tooltipBottomRight, tooltipTop, tooltipTopLeft, tooltipTopRight)
import Amcss.Component.Window as Window
import Browser exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attributes


main =
    Browser.element { init = init, view = view >> toUnstyled, update = update, subscriptions = subscriptions }


type Msg
    = Popup Popup.Msg
    | Flyover Flyover.Msg


type alias Flags =
    Maybe Int


type alias Model =
    { tooltip : Popup.Model
    , dropdown : Popup.Model
    , modal : Flyover.Model
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Model
        (Popup.init "popup" |> Popup.centerAligned)
        (Popup.init "dropdown" |> Popup.leftAligned |> Popup.belowField |> Popup.leftAnchored)
        (Flyover.init "modal")
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Popup popupMsg ->
            let
                tooltipUpdate =
                    Popup.update Popup popupMsg model.tooltip

                dropdownUpdate =
                    Popup.update Popup popupMsg model.dropdown
            in
            ( { model
                | tooltip = Tuple.first tooltipUpdate
                , dropdown = Tuple.first dropdownUpdate
              }
            , Cmd.batch [ Tuple.second tooltipUpdate, Tuple.second dropdownUpdate ]
            )

        Flyover flyoverMsg ->
            let
                modalUpdate =
                    Flyover.update Flyover flyoverMsg model.modal
            in
            ( { model
                | modal = Tuple.first modalUpdate
              }
            , Cmd.batch [ Tuple.second modalUpdate ]
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    Amcss.window
        [ header []
            [ Amcss.group3 nav
                [ Group.directionRow
                , Group.justifyContentCenter
                ]
                [ Amcss.link3 [ Link.active ]
                    [ Attributes.href "/" ]
                    [ text "Nav 1" ]
                , Amcss.link2 [ Attributes.href "/" ]
                    [ text "Nav 2" ]
                , Amcss.link2 [ Attributes.href "/" ]
                    [ text "Nav 3" ]
                ]
            ]
        , Amcss.group2 main_
            [ Amcss.group2 section
                [ h2 []
                    [ text "Popup" ]
                , h3 []
                    [ text "Tooltip" ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ tooltipTopLeft (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup1"
                        (text "Top Left")
                        []
                        [ text "Button" ]
                    , tooltipTop (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup2"
                        (text "Top")
                        []
                        [ text "Button" ]
                    , tooltipTopRight (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup3"
                        (text "Top Right")
                        []
                        [ text "Button" ]
                    , tooltipBottomLeft (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup4"
                        (text "Bottom Left")
                        []
                        [ text "Button" ]
                    , tooltipBottom (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup5"
                        (text "Bottom")
                        []
                        [ text "Button" ]
                    , tooltipBottomRight (Amcss.button3 [])
                        model.tooltip
                        Popup
                        "popup6"
                        (text "Bottom Right")
                        []
                        [ text "Button" ]
                    ]
                , h3 []
                    [ text "Dropdown" ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ dropdown
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown1"
                        []
                        [ text "Button" ]
                        (Amcss.group3 div
                            [ Group.spacingDisable ]
                            [ Amcss.link2 [ Attributes.href "/" ] [ text "First Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Second Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Third Entry" ]
                            ]
                        )
                    , dropdownRight
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown2"
                        []
                        [ text "Button" ]
                        (Amcss.group3 div
                            [ Group.spacingDisable ]
                            [ Amcss.link2 [ Attributes.href "/" ] [ text "First Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Second Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Third Entry" ]
                            ]
                        )
                    , dropdownRight
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown3"
                        []
                        [ text "Button" ]
                        (Amcss.group3 div
                            [ Group.spacingDisable ]
                            [ Amcss.link2 [ Attributes.href "/" ] [ text "First Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Second Entry" ]
                            , Amcss.link2 [ Attributes.href "/" ] [ text "Third Entry" ]
                            ]
                        )
                    ]
                ]
            , Amcss.group2 section
                [ h2 []
                    [ text "Breadcrumb" ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.link2 [ Attributes.href "/" ]
                        [ text "Home" ]
                    , Html.span
                        []
                        [ text "/" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Library" ]
                    , Html.span
                        []
                        [ text "/" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Data" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Html.span []
                        [ text "Home" ]
                    , Html.span []
                        [ text "/" ]
                    , Html.span []
                        [ text "Library" ]
                    , Html.span []
                        [ text "/" ]
                    , Html.span []
                        [ text "Data" ]
                    ]
                ]
            , Amcss.group2 section
                [ h2 []
                    [ text "Link" ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link
                        [ text "Link" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.spacingDisable ]
                    [ Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionColumn, Group.spacingDisable ]
                    [ Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    , Amcss.link2 [ Attributes.href "/" ]
                        [ text "Link" ]
                    ]
                ]
            , Amcss.group2 section
                [ h2 []
                    [ text "Button" ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.button
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedAll ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.displayGhost ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.disabled ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.button2
                        [ Button.sizeMedium ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.roundedSome
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.roundedAll
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.displayGhost
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.button2
                        [ Button.sizeLarge ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.roundedSome
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.roundedAll
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.displayGhost
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedAll ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.displayGhost ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.disabled ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button2
                        [ Button.sizeMedium ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.roundedSome
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.roundedAll
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.displayGhost
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeMedium
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button2
                        [ Button.sizeLarge ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.roundedSome
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.roundedAll
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.displayGhost
                        ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.sizeLarge
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button2
                        [ Button.roundedAll ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedAll ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedAll
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group4 div
                    [ Group.directionColumn, Group.homogenousEnable ]
                    [ Attributes.attribute "style" "width: 30%" ]
                    [ Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionColumn ]
                    [ Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome ]
                        [ text "Button" ]
                    , Amcss.button2
                        [ Button.roundedSome
                        , Button.disabled
                        ]
                        [ text "Button" ]
                    ]
                ]
            , Amcss.group2 section
                [ h2 []
                    [ text "Form" ]
                , Amcss.input
                    [ Attributes.attribute "type" "text", Attributes.attribute "value" "Text" ]
                , Amcss.input
                    [ Attributes.attribute "type" "text", Attributes.attribute "value" "Text", Attributes.attribute "required" "true" ]
                , Amcss.input
                    [ Attributes.attribute "type" "text", Attributes.attribute "value" "Text", Attributes.attribute "disabled" "true" ]
                , Amcss.group3 div
                    [ Group.directionRow, Group.homogenousEnable ]
                    [ Amcss.button [ text "Do something" ]
                    , Amcss.input
                        [ Attributes.attribute "type" "text", Attributes.attribute "value" "Text" ]
                    ]
                , Amcss.group3 div
                    [ Group.directionRow ]
                    [ Amcss.button [ text "Do something" ]
                    , Amcss.input
                        [ Attributes.attribute "type" "text", Attributes.attribute "value" "Text" ]
                    ]
                , Amcss.input [ Attributes.attribute "type" "date" ]
                , Amcss.input [ Attributes.attribute "type" "date", Attributes.attribute "required" "true" ]
                , Amcss.input [ Attributes.attribute "type" "date", Attributes.attribute "disabled" "true" ]
                , Amcss.select
                    [ option []
                        [ text "" ]
                    , option []
                        [ text "Option" ]
                    ]
                , Amcss.select2 [ Attributes.attribute "required" "true" ]
                    [ option []
                        [ text "" ]
                    , option []
                        [ text "Option" ]
                    ]
                , Amcss.input [ Attributes.attribute "type" "checkbox" ]
                , Amcss.input [ Attributes.attribute "type" "checkbox", Attributes.attribute "required" "true" ]
                , Amcss.input [ Attributes.attribute "type" "checkbox", Attributes.attribute "disabled" "true" ]
                , Amcss.input [ Attributes.attribute "type" "radio" ]
                , Amcss.input [ Attributes.attribute "type" "radio", Attributes.attribute "required" "true" ]
                , Amcss.input [ Attributes.attribute "type" "radio", Attributes.attribute "disabled" "true" ]
                ]
            ]
        , Popup.mappedView Popup model.tooltip model.tooltip.id

        {--
        , div
            [ Amcss.Html.component Flyover.component
            , Amcss.Html.attribute Flyover.visible
            , Amcss.Html.attribute Flyover.fullWidthEnable
            , Amcss.Html.attribute Flyover.fullHeightEnable
            , Amcss.Html.attribute Flyover.clickThroughDisable
            , Amcss.Html.attribute Flyover.overflowHidden
            ]
            [ div [ Amcss.Html.component Backdrop.component ] [] ]
        , div
            [ Amcss.Html.component Flyover.component
            , Amcss.Html.attribute Flyover.clickThroughEnable
            , Amcss.Html.attribute Flyover.overflowHidden
            ]
            [ div
                [ Amcss.Html.component Flyover.component
                , Amcss.Html.attribute Flyover.visible
                , Amcss.Html.attribute Flyover.fullWidthEnable
                , Amcss.Html.attribute Flyover.fullHeightEnable
                , Amcss.Html.attribute Flyover.clickThroughEnable
                , Amcss.Html.attribute Flyover.overflowScrollable
                ]
                [ div
                    [ Amcss.Html.component Modal.component
                    , Amcss.Html.attribute Modal.alignCenter
                    , Amcss.Html.attribute Modal.enterTop
                    ]
                    [ h1 [] [ text "Line 1" ]
                    , h1 [] [ text "Line 2" ]
                    , h1 [] [ text "Line 3" ]
                    , h1 [] [ text "Line 4" ]
                    , h1 [] [ text "Line 5" ]
                    , h1 [] [ text "Line 6" ]
                    , h1 [] [ text "Line 7" ]
                    , h1 [] [ text "Line 8" ]
                    , h1 [] [ text "Line 9" ]
                    , h1 [] [ text "Line 10" ]
                    , h1 [] [ text "Line 11" ]
                    ]
                ]
            ]
            --}
        ]
