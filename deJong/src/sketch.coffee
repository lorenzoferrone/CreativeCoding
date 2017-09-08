# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'


x = 0
y = 0

a = -2.24
b = 0.43
c = -0.65
d = -1.45

color = [100, 100, 100, 1]

updateColor = (color) ->
    if frameCount % 100 == 0
        color[0] = (color[0] + 10) % 255
        color[1] = (color[1] + 20) % 255
        color[2] = (color[2] + 30) % 255
        stroke color

iterate = (x, y, a, b, c, d) ->
    xx = Math.sin(a*y) - Math.cos(b*x)
    yy = Math.sin(c*x) - Math.cos(d*y)
    return [xx, yy]
    # return [x, y]
    # return [xx, yy]

setup =  () ->
    createCanvas windowWidth, windowHeight
    stroke color
    # a = random -1, 1
    # b = random -1, 1
    # c = random -1, 1
    # d = random -1, 1

    background 51


draw = () ->
    # updateColor color
    [x, y] = iterate(x, y, a, b, c, d)

    ellipse(map(x, -2, 2, 0, windowWidth), map(y, -2, 2, 0, windowHeight), 1, 1)
    # console.log x, y









window.setup = setup
window.draw = draw
