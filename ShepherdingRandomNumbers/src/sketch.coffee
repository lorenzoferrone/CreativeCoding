# {Grid} = require '../../Utils/Grid'
{Dot} = require './dot'

dots = []

numDots = 1000

setup = () ->
    createCanvas windowWidth, windowHeight
    for i in [1 ... numDots]
        #messi linearmente
        # d = new Dot i*(windowWidth/numDots), windowHeight/2, 1

        # cerchio
        d = new Dot(windowWidth/2 + 100*Math.cos(i*2*Math.PI/numDots), windowHeight/2 + 100*Math.sin(i*2*Math.PI/numDots), 1)

        # d.target = createVector i*(windowWidth/numDots), random windowHeight
        d.regularVelocity = createVector 0, 0
        dots.push(d)


    background 51
    stroke 100, 100, 100, 80
    fill 100, 100, 100, 80




draw = () ->

    # background 51

    for dot, index in dots
        dot.draw()



        # if dot.hasArrived(dot.target)
        #     # if dot has arrived to target, create another target
        #     dot.target = createVector dot.location.x, random windowHeight
        #
        #
        # # draw target
        # # noFill()
        # # ellipse dot.target.x, dot.target.y, 20, 20
        #
        #
        # dot.arrive dot.target

        leftNodes = dots.slice(0, index)
        specialSpeed = (d.regularVelocity for d in leftNodes).reduce (a, b) ->
            a.add b
        , createVector 0, 0
        # specialSpeed.div(index + 1)
        dot.regularVelocity = dot.regularVelocity.add(createVector random(-1, 1), random(-1, 1))
        dot.velocity = specialSpeed
        dot.velocity.limit(dot.maxSpeed)



        # block at walls
        if dot.location.y < 20
            dot.location.y = 20
        if dot.location.y > windowHeight - 20
            dot.location.y = windowHeight - 20

        if dot.location.x < 20
            dot.location.x = 20
        if dot.location.x > windowWidth - 20
            dot.location.x = windowWidth - 20
        # dot.bounce()
        dot.move()









window.setup = setup
window.draw = draw
