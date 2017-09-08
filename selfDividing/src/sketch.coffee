# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'

color = [100, 100, 100, 100]
time = 0
subdivisions = 5

setup =  () ->
    createCanvas windowWidth, windowHeight
    background 51

    # fill 100, 100, 100, 50
    # frameRate 1


draw = () ->
    background 51
    # stroke 100, 100, 100, 100

    lines = 6

    for i in [1 .. lines-1]

        originalLine = [50, i*windowHeight/lines,  windowWidth - 50, i*windowHeight/lines]
        # line originalLine...

        fractal originalLine..., subdivisions

    time = time + 0.00001


fractal = (a, b, c, d, n) ->
    if n == 1
        stroke 100, 100, 100, 200
        divideLine(a, b, c, d)
    else
        stroke 100, 100, 100, 0
        # color[3] = map n, 1, subdivisions, 10, 100
        # stroke color
        [l1, l2] = divideLine a, b, c, d

        fractal l1..., n-1
        fractal l2..., n-1


divideLine = (a, b, c, d) ->
    [x, y] = midpoint(a, b, c, d)

    l = mag(c - a, d - b)

    x = x + map(noise(x, y, time), 0, 1, -l/4, l/4)
    y = y + map(noise(y, y, time), 0, 1, -l/4, l/4)

    # x = x + random -l/4, l/4
    # y = y + random -l/4, l/4

    line a, b, x, y
    line x, y, c, d
    return [[a, b, x, y], [x, y, c, d]]


midpoint = (a, b, c, d) ->
    return [Math.abs(a + c)/2, Math.abs(b + d)/2]





window.setup = setup
window.draw = draw
