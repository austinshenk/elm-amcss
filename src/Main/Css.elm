module Main.Css exposing (main)

import Amcss.Component.Button
import Amcss.Component.Flyover
import Amcss.Component.Flyover.Backdrop
import Amcss.Component.Flyover.Modal
import Amcss.Component.Form
import Amcss.Component.Group
import Amcss.Component.Link
import Amcss.Component.Popup
import Amcss.Component.Popup.Dropdown
import Amcss.Component.Popup.Tooltip
import Amcss.Component.Window
import Amcss.Css.Default as Default
import Amcss.Css.Normalize as Normalize
import Browser
import Css.Global exposing (global)
import Html.Styled exposing (Html, toUnstyled)


type Msg
    = Noop


type alias Flags =
    Maybe Int


type alias Model =
    String


main : Program Flags Model Msg
main =
    Browser.element { init = init, view = view >> toUnstyled, update = update, subscriptions = subscriptions }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( "", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update _ _ =
    ( "", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    global
        (List.concat
            [ Normalize.css
            , Default.css
            , Amcss.Component.Window.css
            , Amcss.Component.Group.css
            , Amcss.Component.Button.css
            , Amcss.Component.Link.css
            , Amcss.Component.Form.css
            , Amcss.Component.Popup.css
            , Amcss.Component.Popup.Tooltip.css
            , Amcss.Component.Popup.Dropdown.css
            , Amcss.Component.Flyover.css
            , Amcss.Component.Flyover.Backdrop.css
            , Amcss.Component.Flyover.Modal.css
            ]
        )
