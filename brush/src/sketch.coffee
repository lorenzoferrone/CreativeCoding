 # coffee -bo ./app -cw ./src/


{Grid, Dot} = require './app/grid'
{Path} = require './app/path'

w = 40
cols =  rows = null

g = null
paths = [new Path()]
console.log paths
selectedDots = []


setup =  () ->
    createCanvas windowWidth, windowHeight
    # create Grid
    # el = document.getElementById('defaultCanvas0')
    # ctx = el.getContext('2d');
    # ctx.shadowBlur = 10
    # ctx.shadowColor = 'rgb(0, 0, 0)'


    g = new Grid()
    g.draw()

    return


draw = () ->

    background 51
    g.draw()

    #highlight dots
    d = g.near(mouseX, mouseY)
    d.highlight()

    #draw line
    for p in paths
        p.draw()


mousePressed = () ->
    if mouseButton == LEFT
        d = g.near(mouseX, mouseY)
        d.selected = !d.selected

        [..., p] = paths
        p.path.push([d.x, d.y])


        if keyIsPressed and keyCode == 18
            #rimuovi da ogni path
            for p in paths
                for point, index in p.path
                    if (point[0] == d.x) and (point[1] == d.y)
                        p.path.splice(index, 1)

    else
        d = g.near(mouseX, mouseY)
        d.selected = !d.selected
        p = new Path()
        paths.push(p)
        p.path.push([d.x, d.y])
