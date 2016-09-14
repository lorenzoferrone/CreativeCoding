Vector = p5.Vector
{Walker} = require('./app/walker')

tree = []
r = 2

maxWalkers = 2000
iteration = 10

walkers = []


setup =  () ->
    createCanvas windowWidth, windowHeight
    background(51)
    # colorMode(HSB)

    w = new Walker(r)
    w.pos = createVector(width/2, height/2)
    tree[0] = w

    for i in [1..maxWalkers]
        walker = new Walker(r)
        walkers.push(walker)

    fill 100



draw = () ->
    background(51)

    for p in tree
        noStroke()
        p.draw()

    for walker in walkers
        walker.draw()


    for n in [1..iteration]
        for walker in walkers by -1

            walker.check(tree)
            if not walker.stuck
                # walker.check(tree)
                walker.walk()

            else
                tree.push(walker)
                walkers.splice(walkers.indexOf(walker), 1)
                # r = max(r/2, 1)
                # walkers.push(new Walker(r))

    while walkers.length < maxWalkers
        walkers.push(new Walker(r))

    # r = max(r*0.999, 5)
    #r = r*0.999
