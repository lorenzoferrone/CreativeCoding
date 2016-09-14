class @Walker
    constructor: (@position, @grid) ->
        @r = random 255
        @g = random 255
        @b = random 255

        @trail = []

        # fill 100, 200, 50, 100
        @direction = sample [0, PI/4, PI/2, 3*PI/4, PI, 5*PI/4, 6*PI/4, 7*PI/4]
        ellipse(@position.x, @position.y, 10, 10)

    update: () ->
        newDirection = sample [0, 0, 0, PI/2, -PI/2, PI/4, -PI/4]
        # devo trasformare la nuova direzione relativamente alla vecchia
        newDirection = newDirection + @direction
        @lastPosition = @position
        newVec = p5.Vector.fromAngle newDirection
        @position = p5.Vector.add @position, newVec.setMag(20)
        @direction = newDirection
        dot = @grid.near(@position.x, @position.y)
        if dot != undefined
            @trail.push dot

    draw: () ->
        stroke @r, @g, @b, 100
        # strokeWeight 5
        #line @lastPosition.x, @lastPosition.y, @position.x, @position.y
        # noFill()
        for d in @trail
            # console.log d
            d.highlight(@r, @g, @b)
        polygonal(@trail)
