module Main exposing (main)

import Amcss
import Amcss.Component.Button as Button
import Amcss.Component.Flyover as Flyover
import Amcss.Component.Flyover.Backdrop as Backdrop
import Amcss.Component.Flyover.Modal as Modal
import Amcss.Component.Form as Form
import Amcss.Component.Group as Group
import Amcss.Component.Link as Link
import Amcss.Component.Popup as Popup
import Amcss.Component.Popup.Dropdown as Dropdown exposing (dropdown, dropdownRight)
import Amcss.Component.Popup.Tooltip as Tooltip exposing (tooltip, tooltipBottom, tooltipBottomLeft, tooltipBottomRight, tooltipTop, tooltipTopLeft, tooltipTopRight)
import Amcss.Component.Window as Window
import Amcss.Html
import Browser exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as HtmlAttributes
import Html.Styled.Events as HtmlEvents


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
    div [ Amcss.Html.component Window.component ]
        [ header []
            [ nav
                [ Amcss.Html.component Group.component
                , Amcss.Html.attribute Group.directionRow
                , Amcss.Html.attribute Group.justifyContentCenter
                ]
                [ a [ Amcss.Html.attribute Link.hrefVoid, Amcss.Html.attribute Link.active ]
                    [ text "Nav 1" ]
                , a [ Amcss.Html.attribute Link.hrefVoid ]
                    [ text "Nav 2" ]
                , a [ Amcss.Html.attribute Link.hrefVoid ]
                    [ text "Nav 3" ]
                ]
            ]
        , main_ [ Amcss.Html.component Group.component ]
            [ section [ Amcss.Html.component Group.component ]
                [ h2 []
                    [ text "Popup" ]
                , h3 []
                    [ text "Tooltip" ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
                    [ dropdown
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown1"
                        []
                        [ text "Button" ]
                        (div
                            [ Amcss.Html.component Group.component, Amcss.Html.attribute Group.spacingDisable ]
                            [ a [ Amcss.Html.attribute Link.hrefVoid ] [ text "First Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Second Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Third Entry" ]
                            ]
                        )
                    , dropdownRight
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown2"
                        []
                        [ text "Button" ]
                        (div
                            [ Amcss.Html.component Group.component, Amcss.Html.attribute Group.spacingDisable ]
                            [ a [ Amcss.Html.attribute Link.hrefVoid ] [ text "First Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Second Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Third Entry" ]
                            ]
                        )
                    , dropdownRight
                        (Amcss.button3 [])
                        model.dropdown
                        Popup
                        "dropdown3"
                        []
                        [ text "Button" ]
                        (div
                            [ Amcss.Html.component Group.component, Amcss.Html.attribute Group.spacingDisable ]
                            [ a [ Amcss.Html.attribute Link.hrefVoid ] [ text "First Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Second Entry" ]
                            , a [ Amcss.Html.attribute Link.hrefVoid ] [ text "Third Entry" ]
                            ]
                        )
                    ]
                ]
            , section [ Amcss.Html.component Group.component ]
                [ h2 []
                    [ text "Breadcrumb" ]
                , div [ Amcss.Html.component Group.component, Amcss.Html.attribute Group.directionRow ]
                    [ a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Home" ]
                    , Html.span
                        []
                        [ text "/" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Library" ]
                    , Html.span
                        []
                        [ text "/" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Data" ]
                    ]
                , div [ Amcss.Html.component Group.component, Amcss.Html.attribute Group.directionRow ]
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
            , section [ Amcss.Html.component Group.component ]
                [ h2 []
                    [ text "Link" ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
                    [ a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    , a [ Amcss.Html.attribute Link.hrefPound ]
                        [ text "Link" ]
                    , a []
                        [ text "Link" ]
                    ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.spacingDisable
                    ]
                    [ a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionColumn
                    , Amcss.Html.attribute Group.spacingDisable
                    ]
                    [ a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    , a [ Amcss.Html.attribute Link.hrefVoid ]
                        [ text "Link" ]
                    ]
                ]
            , section [ Amcss.Html.component Group.component ]
                [ h2 []
                    [ text "Button" ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionColumn
                    , Amcss.Html.attribute Group.homogenousEnable
                    , HtmlAttributes.attribute "style" "width: 30%"
                    ]
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
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionColumn
                    ]
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
            , section [ Amcss.Html.component Group.component ]
                [ h2 []
                    [ text "Form" ]
                , input
                    [ Amcss.Html.attribute Form.typeOfText
                    , HtmlAttributes.attribute "value" "Text"
                    ]
                    []
                , input
                    [ Amcss.Html.attribute Form.typeOfText
                    , Amcss.Html.attribute Form.inputRequired
                    , HtmlAttributes.attribute "value" "Text"
                    ]
                    []
                , input
                    [ Amcss.Html.attribute Form.typeOfText
                    , Amcss.Html.attribute Form.inputDisabled
                    , HtmlAttributes.attribute "value" "Text"
                    ]
                    []
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    , Amcss.Html.attribute Group.homogenousEnable
                    ]
                    [ Amcss.button [ text "Do something" ]
                    , input
                        [ Amcss.Html.attribute Form.typeOfText
                        , HtmlAttributes.attribute "value" "Text"
                        ]
                        []
                    ]
                , div
                    [ Amcss.Html.component Group.component
                    , Amcss.Html.attribute Group.directionRow
                    ]
                    [ Amcss.button [ text "Do something" ]
                    , input
                        [ Amcss.Html.attribute Form.typeOfText
                        , HtmlAttributes.attribute "value" "Text"
                        ]
                        []
                    ]
                , input [ Amcss.Html.attribute Form.typeOfDate ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfDate, Amcss.Html.attribute Form.inputRequired ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfDate, Amcss.Html.attribute Form.inputDisabled ]
                    []
                , select []
                    [ option []
                        [ text "" ]
                    , option []
                        [ text "Option" ]
                    ]
                , select [ Amcss.Html.attribute Form.selectRequired ]
                    [ option []
                        [ text "" ]
                    , option []
                        [ text "Option" ]
                    ]
                , input [ Amcss.Html.attribute Form.typeOfCheckbox ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfCheckbox, Amcss.Html.attribute Form.inputRequired ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfCheckbox, Amcss.Html.attribute Form.inputDisabled ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfRadio ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfRadio, Amcss.Html.attribute Form.inputRequired ]
                    []
                , input [ Amcss.Html.attribute Form.typeOfRadio, Amcss.Html.attribute Form.inputDisabled ]
                    []
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
