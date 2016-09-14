# general formula:
# steering = desired - velocity

DNA = require './dna.js'

class Food
    constructor: (x, y) ->
        @location = createVector x, y
        @poisonous = false

    draw: () ->
        if @poisonous
            fill(250, 0, 100, 150)
        else
            fill(0, 150, 0, 150)
        noStroke()
        ellipse(@location.x, @location.y, 15, 15)

class Agent
    constructor: (x, y, @dna) ->
        @location = createVector x, y
        @velocity = createVector random(-4, 4), random(-4, 4)
        @acceleration = createVector 0, 0

        if @dna is undefined
            @dna = new DNA(undefined, 10)
        @maxSpeed = map @dna.genes[0], 0, 1, 0.1, 4
        @maxForce = map @dna.genes[1], 0, 1, 0.5, 1
        @r        = map @dna.genes[2], 0, 1, 20, 40
        @sight    = map(@dna.genes[3], 0, 1, 50, 150) + @r/2
        @color    = map @dna.genes[4], 0, 1, 100, 200
        @age      = map @dna.genes[5], 0, 1, 90, 110
        @health   = map @dna.genes[6], 0, 1, 90, 110

        @velocity.limit(@maxSpeed)


    applyForce: (force) ->
        @acceleration.add(force)

    reproduce: () ->
        if random() < 0.001
            childDNA = @dna.copy()
            childDNA.mutate()
            a = new Agent(@location.x + @r, @location.y + @r, childDNA)
            return a

    see: (environment) ->
        # a generic function to filter all the entities that this agent "senses"
        neighbour = []
        for entity in environment.entities
            if entity isnt @
                vector = p5.Vector.sub @location, entity.location
                if vector.mag() < @sight
                    if p5.Vector.angleBetween(@velocity, vector) > HALF_PI
                        neighbour.push entity
        return neighbour

    drawSight: (elements) ->
        stroke(100, 100, 100, 100)
        fill(100, 100, 100, 100)
        for n in elements
            line @location.x, @location.y, n.location.x, n.location.y

            distance = dist(@location.x, @location.y, n.location.x, n.location.y)
            textPos =
                x: (@location.x + n.location.x)/2,
                y: (@location.y + n.location.y)/2

            text(distance.toFixed(0), textPos.x, textPos.y, 50, 50)

    steer: (desired) ->
        steer = p5.Vector.sub(desired, @velocity)
        steer.limit @maxForce
        @applyForce steer

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
        if d < 500
            m = map d, 0, 100, 0, @maxSpeed
            desired.mult m
        else
            desired.mult @maxSpeed
        @steer desired

    seek: (target) ->
        desired = p5.Vector.sub(target, @location)
        desired.setMag(@maxSpeed)
        @steer desired

    decideTarget: (targets) ->
        # per il momento: insegue il piu vicino cibo non velenoso, senno wander
        # in futuro dovrà essere qualcosa di piu avanzato!!
        targets = targets.filter((element) =>
            return (element instanceof Food) and (not element.poisonous))

        if targets.length > 0
            targets.sort (a, b) =>
                if dist(@location.x, @location.y, a.location.x, a.location.y) > dist(@location.x, @location.y, b.location.x, b.location.y)
                    return 1
                else
                    return -1
            @seek targets[0].location
        else
            @wander(40)


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

    avoid: (target) ->
        # the inverse of seek
        desired = p5.Vector.sub(@location, target)
        d = desired.mag()
        if d < @sight
            desired.setMag(map d, 0, @sight, @maxSpeed, 0)
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

    move: (environment) ->
        @avoidWalls()
        @bounce()

        neighbour = @see environment
        @decideTarget neighbour
        @drawSight neighbour

        # apply
        @velocity.add @acceleration
        @location.add @velocity
        @acceleration.mult 0

    draw: () ->
        fill @color, @color, @color, map min(@health, @age), 0, 100, 10, 255
        noStroke()
        ellipse(@location.x, @location.y, @r, @r)
        noFill()
        stroke @color, @color, @color, 100

        # angles = p5.Vector.angleBetween @velocity, @location
        # arc(@location.x, @location.y, 2*@sight, 2*@sight, 0, -angles, angles)
        ellipse(@location.x, @location.y, 2*@sight, 2*@sight)


module.exports = {Agent, Food}
