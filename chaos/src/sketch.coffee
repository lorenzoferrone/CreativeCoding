# coffee -bo ./app -cw ./src/
{Particle} = require './app/particle'
Gibber = require 'p5.gibber.js'


count = 1000
particles = []

keyTyped = () ->
    if key == 'p'
        @a.disconnect()
        noLoop()

setup =  () ->
    createCanvas windowWidth, windowHeight
    for i in [1 .. count]
        # initialize particle
        x = random -2500, width + 2500
        y = random -2500, height + 2500
        vx = random -4, 4
        vy = random -4, 4
        type = random [0, 1, 2, 3]
        force = 0.1 + type / 200
        p = new Particle(x, y, vx, vy, type, force)
        @particles.push(p)

    @a = Sine {}


draw = () ->
    # randomSeed 0
    background 70

    total = 0
    # background(@follow.getValue() * 255 )


    # [..., penultimateP, lastP] = particles

    leadingParticles = particles[-1..]

    for lasts in leadingParticles
        lasts.x = lasts.x + random -500, 500
        lasts.y = lasts.y + random -500, 500

        lasts.x = constrain lasts.x, 50, width - 50
        lasts.y = constrain lasts.y, 50, height - 50

        # console.log lastP

        lasts.vx = 0
        lasts.vy = 0
        lasts.force = 2000
        lasts.type = 2

    # beginShape(LINES)  # POINTS al momento non funziona nella libreria :(
    # for particle in particles
    #     particle.interact(lastP)
    #     particle.update()
    #
    #     vertex(particle.x, particle.y)
    #
    # endShape()


    for particle in particles
        for leading in leadingParticles
            particle.interact(leading)
            particle.update()

        total = total + particle.vx**2 + particle.vy**2

        # vertex(particle.x, particle.y)

        point(particle.x, particle.y)
        #ellipse(particle.x, particle.y, 10, 10)

    # console.log total
    # total = constrain total, -10000, 10000
    # total = constrain total 1000
    @a.frequency = total/100


    # stroke(255, 0, 0)
    # ellipse(lastP.x, lastP.y, 20, 20)
