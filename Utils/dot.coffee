# general formula:
# steering = desired - velocity


class Dot
    constructor: (x, y, @r) ->
        @location = createVector x, y
        @velocity = createVector 0, 0
        @acceleration = createVector 0, 0

        @maxSpeed = 1
        @maxForce = 1

        @velocity.limit(@maxSpeed)


    applyForce: (force) ->
        @acceleration.add(force)


    steer: (desired) ->
        steer = p5.Vector.sub(desired, @velocity)
        steer.limit @maxForce
        @applyForce steer

    attract: (target) ->
        force = p5.Vector.sub(target, @location)
        force = force.div(force.mag()).mult 0.002
        @applyForce force

    repel: (target) ->
        force = p5.Vector.sub(@location, target)
        force = force.div(force.mag()) .mult 0.002
        @applyForce force

    wander: (radius) ->
        angleMode(DEGREES);
        direction = @velocity.copy()
        direction.setMag(4*@r + radius)
        futureLocation = p5.Vector.add(@location, direction)
        angle = random 0, 360
        position = p5.Vector.fromAngle angle
        target = p5.Vector.add(futureLocation, p5.Vector.mult(position, radius/2))
        @seek(target)
        angleMode(RADIANS)

    arrive: (target) ->
        desired = p5.Vector.sub(target, @location)
        d = desired.mag()
        desired.normalize()
        if d < 100
            m = map d, 0, 100, 0, @maxSpeed
            desired.mult m
        else
            desired.mult @maxSpeed
        @steer desired

    seek: (target) ->
        desired = p5.Vector.sub(target, @location)
        desired.setMag(@maxSpeed)
        @steer desired


    hasArrived: (target) ->
        target.dist(@location) < 10


    avoidWalls: () ->
        tolerance = 100
        if @location.x > width - tolerance
            desired = createVector(-@maxSpeed, @velocity.y)
        else if @location.x < tolerance
            desired = createVector(@maxSpeed, @velocity.y)
        else if @location.y > height - tolerance
            desired = createVector(@velocity.x, -@maxSpeed)
        else if @location.y < tolerance
            desired = createVector(@velocity.x, @maxSpeed)
        else
            desired = @velocity

        desired.setMag(@maxSpeed)
        @steer desired

    avoid: (target, distance) ->
        # the inverse of seek
        desired = p5.Vector.sub(@location, target)
        d = desired.mag()
        if d < distance
            desired.setMag(map d, 0, distance, @maxSpeed, 0)
        else
            desired = @velocity

        @steer desired

    separate: (targets) ->
        total = createVector 0, 0
        count = 0
        for target in targets
            d = dist(@location.x, @location.y, target.location.x, target.location.y)
            if (d > 0) and (d < @sight + @r + target.r)
                diff = p5.Vector.sub(@location, target.location)
                diff.normalize()
                diff.mult(map d, 0, @sight + @r + target.r, 0, @maxSpeed)
                total.add diff
                count = count + 1
        if count > 0
            total.div count
            total.setMag @maxSpeed
            @steer total

    bounce: () ->
        if (@location.x > width - @r/2) or (@location.x < @r/2)
            @velocity = createVector(-@velocity.x, @velocity.y)

        if (@location.y > height - @r/2) or (@location.y < @r/2)
            @velocity = createVector(@velocity.x, -@velocity.y)



    move: () ->

        # apply
        @velocity.add @acceleration
        @location.add @velocity
        @acceleration.mult 0

    draw: () ->
        # stroke 100, 100, 100, 70
        # fill 100, 100, 100, 70
        ellipse(@location.x, @location.y, @r, @r)
        # point @location.x, @location.y




module.exports = {Dot}
