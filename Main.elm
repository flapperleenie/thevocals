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


main : Program Never String Msg
main =
    Html.program
        { view = view
        , update = update
        , init = ( "Do you want to play?", initialise )
        , subscriptions = \_ -> Sub.none
        }



--MODEL


type alias Model =
    { real : Bool
    , name : String
    , question : String
    , input : Bool
    , test : Bool
    , error : Maybe String
    }



--MESSAGES


type Msg
    = Initialise
    | Generate
    | Pick
    | Compare



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h3 [] [ text question ] ]
        , div [] [ h3 [] [ text name ] ]
        , button [ class "btn", onClick Generate ] [ span [] [ text "Generate new name" ] ]
        , button [ class "btn", onClick Pick ] [ span [] [ text "Pick a band" ] ]
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Initialise ->
            ( input, coinFlip )

        --and { model.question } = "Is this a real vocal group?"
        Generate ->
            ( name, generateRandomName )

        Pick ->
            ( name, pickRandomName )

        Compare ->
            if real == input then
                test == 1
            else
                test == 0


coinFlip : Random.Generator Flip
coinFlip =
    Random.map
        (\b ->
            if b then
                Generate
            else
                Pick
        )


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
        |> Maybe.withDefault ""


generateRandomName : Cmd Msg
generateRandomName =
    let
        makeBand : Int -> String
        makeBand x =
            "The " ++ (pickPart Parts.parts x |> capitalize) ++ "s"
    in
    generate Initialise
        (Random.map makeBand (generator Parts.parts))


pickRandomName : Cmd Msg
pickRandomName =
    let
        pickBand : Int -> String
        pickBand x =
            pickPart Bands.bands x
    in
    generate Initialise
        (Random.map pickBand (generator Bands.bands))
