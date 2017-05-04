module Main exposing (..)

import Html exposing (Html, div, h2, ul, li, span, text, program)
import Html.Attributes exposing (style)
import Mouse
import Keyboard


-- MODEL


type alias Model =
    { x : Int
    , y : Int
    , keycode : Int
    , clicks : Int
    }


initialModel : Model
initialModel =
    { x = 0
    , y = 0
    , keycode = 0
    , clicks = 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = KeyMsg Keyboard.KeyCode
    | MouseMovMsg Mouse.Position
    | MouseClickMsg Mouse.Position



-- VIEW


view : Model -> Html Msg
view { x, y, keycode, clicks } =
    div []
        [ h2 [ style [ ( "margin-bottom", "20px" ) ] ]
            [ text "Application State: " ]
        , ul []
            [ customLi "position at x: " x
            , customLi "position at y: " y
            , customLi "last keycode: " keycode
            , customLi "total clicks: " clicks
            ]
        ]


customLi : String -> a -> Html msg
customLi label content =
    li []
        [ text label
        , span [ style [ ( "color", "tomato" ) ] ]
            [ text (toString content) ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ clicks } as model) =
    case msg of
        KeyMsg code ->
            ( { model | keycode = code }, Cmd.none )

        MouseMovMsg { x, y } ->
            ( { model | x = x, y = y }, Cmd.none )

        MouseClickMsg _ ->
            ( { model | clicks = clicks + 1 }, Cmd.none )



-- SUBSCRPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyMsg
        , Mouse.clicks MouseClickMsg
        , Mouse.moves MouseMovMsg
        ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
