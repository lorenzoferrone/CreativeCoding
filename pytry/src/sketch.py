# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'
# import stdlib

points = []

def setup():
    createCanvas(windowWidth, windowHeight)
    nonlocal points
    points = [[x, windowHeight/2] for x in range(10, windowWidth - 10, 20)]
    stroke(200, 100, 100, 100)
    background(51)


def draw():
    background(51)
    noFill()
    beginShape()
    # curveVertex(first[0], first[1])
    for i, point in enumerate(points[1:-1]):
        curveVertex(point[0], point[1])
        point[1] = point[1] + random(-2, 2)
    # curveVertex(last[0], last[1])
    endShape()


window.setup = setup
window.draw = draw
