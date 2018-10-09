module Amcss.Component.Flyover exposing
    ( Model
    , Msg
    , centerAligned
    , component
    , css
    , enterFromBottom
    , enterFromLeft
    , enterFromRight
    , enterFromTop
    , init
    , invisible
    , isvisible
    , leftAligned
    , rightAligned
    , update
    , view
    )

import Amcss.Component
import Amcss.Html
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Process exposing (..)
import Task exposing (..)
import Time exposing (..)


type alias Model =
    { flyoverId : String, defaultProperties : Properties, id : String, html : Maybe (Html Msg), visible : Bool }


type Msg
    = Show String String (Maybe (Html Msg))
    | Hide String String
    | ClearContent String String


type Align
    = LeftAlign
    | CenterAlign
    | RightAlign


type Enter
    = EnterTop
    | EnterBottom
    | EnterLeft
    | EnterRight


type alias Properties =
    { align : Align, enter : Enter }


init : String -> Model
init popupId =
    Model popupId (Properties CenterAlign EnterTop) "" Nothing False


leftAligned : Model -> Model
leftAligned =
    setAlignment LeftAlign


centerAligned : Model -> Model
centerAligned =
    setAlignment CenterAlign


rightAligned : Model -> Model
rightAligned =
    setAlignment RightAlign


setAlignment : Align -> Model -> Model
setAlignment alignment model =
    let
        defaultProperties =
            model.defaultProperties
    in
    { model
        | defaultProperties =
            { defaultProperties
                | align = alignment
            }
    }


enterFromTop : Model -> Model
enterFromTop =
    setEntrance EnterTop


enterFromBottom : Model -> Model
enterFromBottom =
    setEntrance EnterBottom


enterFromLeft : Model -> Model
enterFromLeft =
    setEntrance EnterLeft


enterFromRight : Model -> Model
enterFromRight =
    setEntrance EnterRight


setEntrance : Enter -> Model -> Model
setEntrance entrance model =
    let
        defaultProperties =
            model.defaultProperties
    in
    { model
        | defaultProperties =
            { defaultProperties
                | enter = entrance
            }
    }


update : (Msg -> a) -> Msg -> Model -> ( Model, Cmd a )
update messageMapping msg model =
    case msg of
        ClearContent flyoverId id ->
            let
                newModel =
                    if isCurrent model flyoverId id && model.visible == False then
                        { model | id = "", html = Nothing }

                    else
                        model
            in
            ( newModel, Cmd.none )

        Hide flyoverId id ->
            if isCurrent model flyoverId id then
                ( { model | id = id, visible = False }
                , Cmd.map messageMapping (delay 300 (ClearContent flyoverId id))
                )

            else
                ( model, Cmd.none )

        Show flyoverId id html ->
            let
                newModel =
                    if isCurrent model flyoverId id then
                        { model | id = id, html = html, visible = True }

                    else
                        model
            in
            ( newModel, Cmd.none )


isCurrent : Model -> String -> String -> Bool
isCurrent { flyoverId, id } currentFlyoverId currentId =
    flyoverId == currentFlyoverId && (id == "" || id == currentId)


delay : Float -> Msg -> Cmd Msg
delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)


view : Model -> String -> Html Msg
view { flyoverId, defaultProperties, id, html, visible } currentId =
    let
        initialAttributes =
            [ Amcss.Html.component component ]

        flyoverBody =
            case html of
                Nothing ->
                    []

                Just content ->
                    [ content ]
    in
    div
        [ Amcss.Html.component component
        , Amcss.Html.attribute clickThroughEnable
        , Amcss.Html.attribute overflowHidden
        ]
        [ div
            [ Amcss.Html.component component
            , Amcss.Html.attribute isvisible
            , Amcss.Html.attribute fullWidthEnable
            , Amcss.Html.attribute fullHeightEnable
            , Amcss.Html.attribute clickThroughEnable
            , Amcss.Html.attribute overflowScrollable
            ]
            flyoverBody
        ]


css =
    [ Amcss.Component.componentToSelector component
        [ position fixed ]
    , Amcss.Component.propertyToSelector [ columnLeft ]
        [ left zero ]
    , Amcss.Component.propertyToSelector [ columnCenter ]
        [ left (pct 50) ]
    , Amcss.Component.propertyToSelector [ columnRight ]
        [ right zero ]
    , Amcss.Component.propertyToSelector [ rowTop ]
        [ top zero ]
    , Amcss.Component.propertyToSelector [ rowCenter ]
        [ top (pct 50) ]
    , Amcss.Component.propertyToSelector [ rowBottom ]
        [ bottom zero ]
    , Amcss.Component.propertyToSelector [ fullWidthEnable ]
        [ width (vw 100) ]
    , Amcss.Component.propertyToSelector [ fullHeightEnable ]
        [ height (vh 100) ]
    , Amcss.Component.propertyToSelector [ clickThroughEnable ]
        [ Css.property "pointer-events" "all" ]
    , Amcss.Component.propertyToSelector [ clickThroughDisable ]
        [ Css.property "pointer-events" "none" ]
    , Amcss.Component.propertyToSelector [ overflowHidden ]
        [ Css.overflow hidden ]
    , Amcss.Component.propertyToSelector [ overflowScrollable ]
        [ Css.overflow auto ]
    ]


component =
    Amcss.Component.component "f"


column =
    Amcss.Component.property component "c"


row =
    Amcss.Component.property component "r"


fullWidth =
    Amcss.Component.property component "w"


fullHeight =
    Amcss.Component.property component "h"


clickThrough =
    Amcss.Component.property component "ct"


visibility =
    Amcss.Component.property component "v"


overflow =
    Amcss.Component.property component "o"


columnLeft =
    Amcss.Component.defaultProperty component "c" "0"


columnCenter =
    column "1"


columnRight =
    column "2"


rowTop =
    Amcss.Component.defaultProperty component "r" "0"


rowCenter =
    row "1"


rowBottom =
    row "2"


fullWidthEnable =
    fullWidth "1"


fullWidthDisable =
    Amcss.Component.defaultProperty component "w" "0"


fullHeightEnable =
    fullHeight "1"


fullHeightDisable =
    Amcss.Component.defaultProperty component "h" "0"


clickThroughEnable =
    Amcss.Component.defaultProperty component "ct" "1"


clickThroughDisable =
    clickThrough "0"


isvisible =
    visibility "1"


invisible =
    visibility "0"


overflowHidden =
    Amcss.Component.defaultProperty component "o" "0"


overflowScrollable =
    overflow "1"
