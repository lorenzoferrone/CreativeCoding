# {Grid} = require '../../Utils/Grid'
{Dot} = require './dot'
{nearestNeighbour} = require './triangulations'
# Gibber = require 'p5.gibber.js'

dots = []
edges = []
osc = null

setup =  () ->
    createCanvas windowWidth, windowHeight
    # ellipse 50, 50, 50, 50
    for i in [1 .. 50]
        dots.push new Dot(random(width), random(height))


    fill 100, 100, 100, 100
    stroke 150, 150, 150, 100

    osc = new p5.Oscillator(440, 'sine')
    osc.setType('sine')
    osc.freq(440)
    osc.amp(1)
    osc.start()

    # @sine = Sine()


draw = () ->
    background 51

    stroke 150, 150, 150, 50
    for dot in dots
        ellipse dot.x, dot.y, 10, 10
        dot.move()

    e = nearestNeighbour dots, 5

    totalDistance = 0
    stroke 100, 100, 100, 100
    for [a, b] in e
        totalDistance = totalDistance + dist a.x, a.y, b.x, b.y
        line a.x, a.y, b.x, b.y

    # console.log(totalDistance)
    # sine.frequency = totalDistance / 10
    osc.freq map(totalDistance, 39000, 41000, 5000, 10000)

    for i in [1 .. 2]
        e = nearestNeighbour dots, i, false

        stroke 100, 100, 100, map(i, 1, 2, 250, 50)
        for [a, b] in e
            line a.x, a.y, b.x, b.y

    nearestNeighbour dots, 2, false


















window.setup = setup
window.draw = draw
