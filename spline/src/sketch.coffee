dots = null

setup = () ->
    createCanvas(windowWidth, windowHeight)
    # dots on a horizontal line in the center
    dots = ([x, windowHeight/2] for x in [0 .. windowWidth] by 50)

    #dots on a circle
    radius = 200
    #dots = ([windowWidth*0.5 + radius*Math.cos(theta), windowHeight*0.5 + radius*Math.sin(theta)] for theta in [0 .. 2*Math.PI] by 0.1)
    background(51)




draw = () ->

    stroke(100, 100, 100, 10)
    noFill()
    beginShape()
    for dot, i in dots
        curveVertex(dot[0], dot[1])
        # j = map(i, 0, dots.length, 0, 10)
        j = 3
        dot[0] = dot[0] + random(-j, j)
        dot[1] = dot[1] + random(-j, j)
    # curveVertex(dots[0][0], dots[0][1])
    # curveVertex(dots[1][0], dots[1][1])
    # curveVertex(dots[2][0], dots[2][1])
    endShape()










window.setup = setup
window.draw = draw
