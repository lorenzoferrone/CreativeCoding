# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'

# dots = null

numDots = 10
numChar = 10

fisherYates = (arr) ->
    i = arr.length
    if i is 0
        return false

    while --i
        j = Math.floor(Math.random() * (i+1))
        [arr[i], arr[j]] = [arr[j], arr[i]] # use pattern matching to swap


dotGrid = (row, column) ->
    dots = []
    for i in [0 ... row]
        for j in [0 ... column]
            dots.push
                x: (windowWidth/2 - (column - 1)*25)  + j * 50
                y: (windowHeight/2 - (row - 1)*25) +  i * 50
    return dots


splitArray = (array, separator) ->
    chunks = []
    if not array.includes -1
        return [array]
    first = array.slice 0, array.indexOf(separator)
    second = array.slice array.indexOf(separator) + 1
    if first != []
        chunks.push first
    chunks.push (splitArray second, separator)

    return chunks


drawChar = (grid, coords) ->
    # grid is a list of dots, coords is a list of coordinates
    # "-1" is a separator between strokes

    noFill()
    beginShape()
    for point in coords
        curveVertex grid[point].x, grid[point].y
    endShape()

    fill 100, 100, 100, 60
    for dot in grid
        ellipse dot.x, dot.y, 2, 2



setup = () ->
    createCanvas windowWidth, windowHeight

    # create chars based on shuffled circles
    # for char in [1 ... numChar]
    #     dots = []
    #     #choose coordinate on a circle
    #     for i in [1 .. random(7, numDots)]
    #         dots.push
    #             x: char * (windowWidth/numChar) + 50*Math.cos(2* i * Math.PI/numDots)
    #             y: windowHeight/2 + 50*Math.sin(2* i * Math.PI/numDots)
    #     # @dots = ({x: random(windowWidth), y: random(windowHeight)} for _ in [1.. numDots])
    #
    #         fisherYates dots
    #         chars.push dots

    # create a single grid

    @grid = dotGrid(4, 2)

    stroke 100, 100, 100


draw = () ->
    background 51
    # strokeWeight 2

    char = [
        [0, 0, 1, 2],
        [5, 6, 7, 7],
        [3, 3, 5, 2]
    ]

    for stroke in char
        drawChar grid, stroke
    # drawChar grid, [5, 6, 7, 6]











window.setup = setup
window.draw = draw
