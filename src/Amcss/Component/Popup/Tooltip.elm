module Amcss.Component.Popup.Tooltip exposing
    ( css
    , tooltip
    , tooltipBottom
    , tooltipBottomLeft
    , tooltipBottomRight
    , tooltipTop
    , tooltipTopLeft
    , tooltipTopRight
    , view
    )

import Amcss.Component
import Amcss.Component.Popup as Popup exposing (..)
import Amcss.Css.StyleGuide as StyleGuide
import Amcss.Html exposing (..)
import Css exposing (..)
import Css.Global exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)


css =
    [ Amcss.Component.componentToSelector component
        [ borderRadius StyleGuide.borderRadius
        , backgroundColor StyleGuide.black
        , color StyleGuide.white
        , padding StyleGuide.spacing
        , Css.property "pointer-events" "none"
        , position relative
        ]
    , Amcss.Component.propertyToSelector [ Popup.positionTop ]
        [ children
            [ Amcss.Component.componentToSelector component
                [ bottom StyleGuide.spacing
                , after
                    [ top (pct 100)
                    , marginTop (px -1)
                    , borderTop3 StyleGuide.spacing solid StyleGuide.black
                    ]
                ]
            ]
        ]
    , Amcss.Component.propertyToSelector [ Popup.positionBottom ]
        [ children
            [ Amcss.Component.componentToSelector component
                [ top StyleGuide.spacing
                , after
                    [ bottom (pct 100)
                    , marginBottom (px -1)
                    , borderBottom3 StyleGuide.spacing solid StyleGuide.black
                    ]
                ]
            ]
        ]
    , each [ Amcss.Component.propertyToSelector [ Popup.positionTop ], Amcss.Component.propertyToSelector [ Popup.positionBottom ] ]
        [ children
            [ Amcss.Component.componentToSelector component
                [ after
                    [ Css.property "content" "''"
                    , position absolute
                    , left (pct 50)
                    , transform (translateX (pct -50))
                    , borderColor StyleGuide.black
                    , borderLeft3 StyleGuide.spacing solid transparent
                    , borderRight3 StyleGuide.spacing solid transparent
                    ]
                ]
            ]
        ]
    ]


component =
    Amcss.Component.component "t"


view : Html a -> Html a
view html =
    Html.div [ Amcss.Html.component component ] [ html ]


tooltip : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltip element model =
    tooltipFull_ model.defaultProperties.align model.defaultProperties.position element model


tooltipTopLeft : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipTopLeft =
    tooltipFull_ LeftAlign Top


tooltipTop : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipTop =
    tooltipFull_ CenterAlign Top


tooltipTopRight : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipTopRight =
    tooltipFull_ RightAlign Top


tooltipBottomLeft : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipBottomLeft =
    tooltipFull_ LeftAlign Bottom


tooltipBottom : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipBottom =
    tooltipFull_ CenterAlign Bottom


tooltipBottomRight : (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipBottomRight =
    tooltipFull_ RightAlign Bottom


tooltipFull_ : Align -> Popup.Position -> (List (Attribute Msg) -> List (Html Msg) -> Html Msg) -> Model a -> String -> Html Msg -> List (Attribute Msg) -> List (Html Msg) -> Html a
tooltipFull_ align position element { popupId, defaultProperties, messageMapping } id popupHtml elementAttributes elementHtml =
    let
        showPopupMsg =
            Show popupId id (Just (view popupHtml)) (Just (Properties align position CenterAnchor defaultProperties.animatePosition))

        hidePopupMsg =
            Hide popupId id
    in
    Html.map messageMapping
        (element
            (elementAttributes
                ++ [ Html.Styled.Attributes.attribute "id" id
                   , onMouseOver showPopupMsg
                   , onFocus showPopupMsg
                   , onMouseLeave hidePopupMsg
                   , onBlur hidePopupMsg
                   ]
            )
            elementHtml
        )
