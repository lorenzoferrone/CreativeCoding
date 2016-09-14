# coffee -bo ./app -cw ./src/

{Grid} = require '../../Utils/Grid'
{Piece} = require './piece'

G = null



setup =  () ->
    createCanvas windowWidth, windowHeight

    G = new Grid(10, 8)

    G.get 5, 6
        .selected = true

    knight = new Piece('knight')

    stroke 100, 100, 100, 200
    noFill()




draw = () ->
    background 51

    G.draw()











window.setup = setup
window.draw = draw
