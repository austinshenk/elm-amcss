module Amcss.Component.Popup exposing
    ( Align(..)
    , Anchor(..)
    , Model
    , Msg(..)
    , Position(..)
    , Properties
    , aboveField
    , belowField
    , centerAligned
    , centerAnchored
    , css
    , init
    , leftAligned
    , leftAnchored
    , mappedView
    , positionBottom
    , positionTop
    , rightAligned
    , rightAnchored
    , update
    , view
    )

import Amcss.Component
import Amcss.Css
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Types exposing (Component, Property)
import Browser.Dom exposing (..)
import Css exposing (..)
import Css.Global exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Process exposing (..)
import String exposing (..)
import Task exposing (..)
import Time exposing (..)


css =
    [ Amcss.Css.component component
        [ position absolute
        , Css.property "transition" "opacity .3s, top .03s, left .03s, transform .03s"
        ]
    , Amcss.Css.selector [ animatePositionDisable ]
        [ Css.property "transition" "opacity .3s" ]
    , Amcss.Css.selector [ invisible ]
        [ Css.property "pointer-events" "none"
        , opacity zero
        ]
    , Amcss.Css.selector [ isvisible ]
        [ opacity (num 1) ]
    , Amcss.Css.selector [ positionTop, anchorLeft ]
        [ transform (translate3d zero (pct -100) zero) ]
    , Amcss.Css.selector [ positionTop, anchorCenter ]
        [ transform (translate3d (pct -50) (pct -100) zero) ]
    , Amcss.Css.selector [ positionTop, anchorRight ]
        [ transform (translate3d (pct -100) (pct -100) zero) ]
    , Amcss.Css.selector [ positionBottom, anchorLeft ]
        [ transform (translate3d zero zero zero) ]
    , Amcss.Css.selector [ positionBottom, anchorCenter ]
        [ transform (translate3d (pct -50) zero zero) ]
    , Amcss.Css.selector [ positionBottom, anchorRight ]
        [ transform (translate3d (pct -100) zero zero) ]
    ]


type alias Model a =
    { popupId : String
    , defaultProperties : Properties
    , id : String
    , html : Maybe (Html Msg)
    , boundingBox : Maybe BoundingBox
    , properties : Maybe Properties
    , visible : Bool
    , messageMapping : Msg -> a
    }


type alias BoundingBox =
    { top : Float, left : Float, width : Float, height : Float }


type Msg
    = Show String String (Maybe (Html Msg)) (Maybe Properties)
    | Hide String String
    | SetPosition String String (Result Error Element)
    | ClearContent String String


type Align
    = LeftAlign
    | CenterAlign
    | RightAlign


type Position
    = Top
    | Bottom


type Anchor
    = LeftAnchor
    | CenterAnchor
    | RightAnchor


type alias Properties =
    { align : Align, position : Position, anchor : Anchor, animatePosition : Bool }


init : String -> (Msg -> a) -> Model a
init popupId messageMapping =
    Model popupId (Properties LeftAlign Bottom LeftAnchor True) "" Nothing Nothing Nothing False messageMapping


leftAligned : Model a -> Model a
leftAligned =
    setAlignment LeftAlign


centerAligned : Model a -> Model a
centerAligned =
    setAlignment CenterAlign


rightAligned : Model a -> Model a
rightAligned =
    setAlignment RightAlign


setAlignment : Align -> Model a -> Model a
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


aboveField : Model a -> Model a
aboveField =
    setPosition Top


belowField : Model a -> Model a
belowField =
    setPosition Bottom


setPosition : Position -> Model a -> Model a
setPosition newPosition model =
    let
        defaultProperties =
            model.defaultProperties
    in
    { model
        | defaultProperties =
            { defaultProperties
                | position = newPosition
            }
    }


leftAnchored : Model a -> Model a
leftAnchored =
    setAnchor LeftAnchor


centerAnchored : Model a -> Model a
centerAnchored =
    setAnchor CenterAnchor


rightAnchored : Model a -> Model a
rightAnchored =
    setAnchor RightAnchor


setAnchor : Anchor -> Model a -> Model a
setAnchor newAnchor model =
    let
        defaultProperties =
            model.defaultProperties
    in
    { model
        | defaultProperties =
            { defaultProperties
                | anchor = newAnchor
            }
    }


update : Msg -> Model a -> ( Model a, Cmd a )
update msg model =
    case msg of
        ClearContent popupId id ->
            let
                newModel =
                    if isCurrent model popupId id && model.visible == False then
                        { model | id = "", html = Nothing }

                    else
                        model
            in
            ( newModel, Cmd.none )

        Hide popupId id ->
            if isCurrent model popupId id then
                ( { model | id = id, visible = False }
                , Cmd.map model.messageMapping (delay 300 (ClearContent popupId id))
                )

            else
                ( model, Cmd.none )

        Show popupId id html properties ->
            if model.popupId == popupId then
                let
                    cmd =
                        Cmd.map model.messageMapping (Task.attempt (SetPosition popupId id) (getElement id))
                in
                if model.id == id then
                    ( { model
                        | id = id
                        , html = html
                        , properties = properties
                        , visible = False
                      }
                    , cmd
                    )

                else
                    ( { model
                        | id = id
                        , html = html
                        , boundingBox = Nothing
                        , properties = properties
                        , visible = False
                      }
                    , cmd
                    )

            else
                ( model, Cmd.none )

        SetPosition popupId id result ->
            let
                newModel =
                    case result of
                        Ok element ->
                            if isCurrent model popupId id then
                                { model
                                    | popupId = popupId
                                    , id = id
                                    , boundingBox = Just (BoundingBox element.element.y element.element.x element.element.width element.element.height)
                                    , visible = True
                                }

                            else
                                model

                        Err _ ->
                            model
            in
            ( newModel, Cmd.none )


delay : Float -> Msg -> Cmd Msg
delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)


isCurrent : Model a -> String -> String -> Bool
isCurrent { popupId, id } currentPopupId currentId =
    popupId == currentPopupId && (id == "" || id == currentId)


mappedView : Model a -> String -> Html a
mappedView model id =
    Html.map model.messageMapping (view model id)


view : Model a -> String -> Html Msg
view { popupId, defaultProperties, id, html, boundingBox, properties, visible } currentId =
    let
        popupBody =
            case html of
                Nothing ->
                    []

                Just content ->
                    [ content ]

        notNothingProperties =
            case properties of
                Nothing ->
                    defaultProperties

                Just p ->
                    p

        ( popupProperties, popupAttributes ) =
            if id /= currentId then
                ( [ invisible, animatePositionToProperty notNothingProperties.animatePosition ], [] )

            else
                case boundingBox of
                    Nothing ->
                        ( [ visibleToProperty visible, animatePositionToProperty notNothingProperties.animatePosition ], [] )

                    Just bb ->
                        calculatePopupPos notNothingProperties bb visible
    in
    Amcss.Component.componentToHtml component Html.div popupProperties popupAttributes popupBody


visibleToProperty : Bool -> Property
visibleToProperty a =
    case a of
        True ->
            isvisible

        False ->
            invisible


calculatePopupPos : Properties -> BoundingBox -> Bool -> ( List Property, List (Attribute Msg) )
calculatePopupPos { align, position, anchor, animatePosition } { top, left, width, height } visible =
    let
        pLeft =
            case align of
                LeftAlign ->
                    left

                CenterAlign ->
                    left + (width / 2)

                RightAlign ->
                    left + width

        pTop =
            case position of
                Top ->
                    top

                Bottom ->
                    top + height
    in
    ( [ alignToProperty align
      , positionToProperty position
      , anchorToProperty anchor
      , animatePositionToProperty animatePosition
      , visibleToProperty visible
      ]
    , [ Html.Styled.Attributes.attribute "style" ("top:" ++ fromFloat pTop ++ "px; left:" ++ fromFloat pLeft ++ "px;") ]
    )


alignToProperty : Align -> Property
alignToProperty a =
    case a of
        LeftAlign ->
            alignLeft

        CenterAlign ->
            alignCenter

        RightAlign ->
            alignRight


positionToProperty : Position -> Property
positionToProperty p =
    case p of
        Top ->
            positionTop

        Bottom ->
            positionBottom


anchorToProperty : Anchor -> Property
anchorToProperty a =
    case a of
        LeftAnchor ->
            anchorLeft

        CenterAnchor ->
            anchorCenter

        RightAnchor ->
            anchorRight


animatePositionToProperty : Bool -> Property
animatePositionToProperty a =
    case a of
        True ->
            animatePositionEnable

        False ->
            animatePositionDisable


component =
    Amcss.Component.component "p"


visibility =
    Amcss.Component.property component "v"


align_ =
    Amcss.Component.property component "a"


position_ =
    Amcss.Component.property component "p"


anchor_ =
    Amcss.Component.property component "c"


animatePosition_ =
    Amcss.Component.property component "n"


invisible =
    visibility "0"


isvisible =
    visibility "1"


alignLeft =
    align_ "1"


alignCenter =
    align_ "2"


alignRight =
    align_ "3"


positionTop =
    position_ "1"


positionBottom =
    position_ "2"


anchorLeft =
    anchor_ "1"


anchorCenter =
    anchor_ "2"


anchorRight =
    anchor_ "3"


animatePositionEnable =
    animatePosition_ "1"


animatePositionDisable =
    animatePosition_ "2"
