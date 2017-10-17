module Main exposing (..)

import Array
import Bands
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Maybe
import Parts
import Random exposing (generate)
import String


--MAIN


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = \_ -> Sub.none
        }



--MODEL


type alias Model =
    { real : Bool
    , name : String
    , question : String
    , input : Bool
    , test : Bool
    , error : String
    }


-- initModel : Model
-- initModel = 
--     Model True, "The cars", "Is it real?", True, True 

optOut : Model
optOut =
    Model True "The cars" "Is it real?" True True  "Error"

init : (Model, Cmd Msg)
init = 
    (optOut, Random.generate coinFlip Random.bool)

--MESSAGES


type Msg
    =   Generate
    | Pick
    | NewFace Int
    -- | Compare


--VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h3 [] [ text model.question ] ]
        , div [] [ h3 [] [ text model.name ] ]
        , button [ class "btn", onClick Generate ] [ span [] [ text "Generate new name" ] ]
        , button [ class "btn", onClick Pick ] [ span [] [ text "Pick a band" ] ]
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- Initialise ->
        --     ( model, Random.generate coinFlip Random.bool )

        --and { model.question } = "Is this a real vocal group?"
        Generate ->
            ( model, Random.generate NewFace (Random.int 0 3) )

        Pick ->
            ( {model | name = pickRandomName }, Cmd.none )

        NewFace newFace -> 
            ( {model | name = pickBandName newFace }, Cmd.none )
        -- Compare ->
        --     if model.real == input then
        --         model.test == 1
        --     else
        --         model.test == 0


coinFlip : Bool -> Msg
coinFlip b =
    if b then
        Generate
    else
        Pick

capitalize : String -> String
capitalize str =
    (String.left 1 >> String.toUpper) str ++ String.dropLeft 1 str


generator : List String -> Random.Generator Int
generator list =
    Random.int 0 (List.length list - 1)


pickPart : List String -> Int -> String
pickPart list i =
    list
        |> Array.fromList
        |> Array.get i
        |> Maybe.withDefault "Not Found"


generateRandomName : Cmd Msg
generateRandomName =
    let
        makeBand : Int -> String
        makeBand x =
            "The " ++ (pickPart Parts.parts x |> capitalize) ++ "s"
    in
    Cmd.none
    -- generate Initialise
    --     (Random.map makeBand (generator Parts.parts))

pickBandName: Int -> String
pickBandName i =
    pickPart Bands.bands i

pickRandomName : String
pickRandomName =
    let
        pickBand : Int -> String
        pickBand x =
            pickPart Bands.bands x
    in

    "Knut"
    -- pickPart Bands.bands (Random.generate Random.int 0 20)
