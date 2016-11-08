# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'


nLines = 50
lines = []


distortLine = (x1, y1, x2, y2, a=1/3, b=2/3) ->
    bezier x1, y1,
           (x1 + x2)*a, (y1 + y2)*a,
           (x1 + x2)*b, (y1 + y2)*b,
           x2, y2

setup =  () ->

    createCanvas windowWidth, windowHeight

    for i in [0 .. nLines]
        side = random [0, 1, 2, 3]
        switch side
            when 0
                x = 0
                y = random height
            when 1
                x = random width
                y = 0
            when 2
                x = width
                y = random height
            when 3
                x = random width
                y = height

        a = random()
        b = 1 - a
        lines.push [x, y, a, b]

    @origin = [width/2, height/2]



draw = () ->
    noFill()
    stroke 100, 100, 100, 100

    background 51

    @origin[0] = @origin[0] + random -2, 2
    @origin[1] = @origin[1] + random -2, 2


    for l in lines

        distortLine mouseX, mouseY, l[0], l[1], l[2], l[3]



    ellipse mouseX, mouseY, 50, 50






window.setup = setup
window.draw = draw
