class @Dot
    constructor: (@x, @y) ->
        # @color = Color(100, 100, 100)

    draw: (r, g, b) ->
        stroke r, g, b, 10
        fill r, g, b, 10
        ellipse @x, @y, 10, 10

    highlight: (r, g, b) ->
        stroke r, g, b, 50
        fill r, g, b, 50
        ellipse @x, @y, 10, 10

class @Grid
    constructor: () ->
        @dots = {}
        for i in [0...width] by 20
            for j in [0...height] by 20
                @dots[[i,j]] = new Dot(i+10, j+10)


    near: (x, y) ->
        # find nearest dot to coordinate
        i = 20*floor(x/20)
        j = 20*floor(y/20)
        @dots[[i, j]]

    draw: () ->
        for _, d of @dots
            d.draw(200, 200, 200)
