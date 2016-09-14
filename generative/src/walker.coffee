class @Walker
    constructor: (@r) ->
        @pos = createVector(random(width), random(height))
        #@pos = randomFromDirection(300)
        @stuck = false

    walk: () ->
        vel = Vector.random2D()
        @pos = @pos.add(vel.mult(3))
        # walker.x += random -2, 2
        # walker.y += random -2, 2
        @pos.x = constrain(@pos.x, 0, width)
        @pos.y = constrain(@pos.y, 0, height)
        return 0


    check: (others) ->
        # r2 = 4 * @r*@r
        for p in others
            distance = @dist(@pos, p.pos)
            # stroke(200, 100)
            # line(@pos.x, @pos.y, p.x, p.y)
            if distance < 3.5 * @r * p.r
                @stuck = true
                return true

        @stuck = false
        return false

    draw: () ->
        # c = map(this.r, 1, 16, 70, 120)
        # fill(100, 100, 45, 100)
        # fill(100)
        # noStroke()
        # point(@pos.x, @pos.y)
        ellipse(@pos.x, @pos.y, 2*@r, 2*@r)
        return 0

    dist: (v, w) ->
        return (v.x - w.x)**2 + (v.y - w.y)**2




randomFromDirection =  (margin) ->
    coinX = random()
    coinY = random()
    if coinX < 0.5
        x = random(margin)
    else
        x = random(width - margin, width)
    if coinY < 0.5
        y = random(margin)
    else
        y = random(height - margin, height)
    return createVector(x, y)
