# coffee -bo ./app -cw ./src/

setup =  () ->
    createCanvas windowWidth, windowHeight, WEBGL
    frameRate(10)

    @scl = 40
    @w = 1500
    @h = 800
    @cols = floor w/scl
    @rows = floor h/scl


    background 51


draw = () ->
    background 51
    stroke 100
    # fill(51)

    # box()
    # translate(-w/2, -h/2, 0)
    # sphere()
    # box()
    # rotateX(-PI/4)
    # translate(w/2, h/2, 0)


    for y in [0 .. rows]
        beginShape(TRIANGLE_STRIP)
        for x in [0 .. cols]
            vertex(x*scl, y*scl, 10)
            vertex(x*scl, (y+1)*scl, 20)


        endShape()
