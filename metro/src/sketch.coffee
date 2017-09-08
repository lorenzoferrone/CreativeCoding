# coffee -bo ./ -cw ./
{Grid, Dot} = require './grid'
{Walker} = require './walker'
{sample, polygonal} = require './utility'

setup =  () ->
    createCanvas windowWidth, windowHeight
    frameRate(50)
    stroke 200, 200, 125, 20
    fill 200, 200, 125, 20
    @walkers = []
    @g = new Grid()
    @g.draw()
    return

draw = () ->
    background(255)
    @g.draw()
    for w in @walkers
        w.update()
        w.draw()

    if key == 'p'
        noLoop()
    # return

mouseClicked = () ->
    @walkers.push(new Walker(createVector(mouseX, mouseY), @g))
