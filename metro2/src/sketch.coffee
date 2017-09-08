{Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'

G = null
# c = null
paths = []

setup =  () ->
    createCanvas windowWidth, windowHeight
    cols = 30
    rows = 20
    G = new Grid cols, rows

    for xy in [[0, 0], [0, rows-1], [cols-1, 0], [cols-1, 19]]
        c = G.get xy...
        c.color = [random(100), random(100), random(100), 200]
        c.selected = true
        paths.push [c]
    frameRate 10




walk = (path) ->
    [rest..., last] = path
    console.log last
    # neighbours
    neigh = G.getNeighbours(last)
    # filtro quelli gia visitati
    neigh = neigh.filter((element) -> element.selected != true)
    # TODO: filtrare rispetto alla direzione (solo angoli ottusi)
    # e anche rispetto alle self-intersection
    cc = random neigh
    if cc is undefined
        return
    else
        cc.selected = true
        cc.color = last.color
        # c = cc
        path.push cc


draw = () ->
    background 51
    G.draw()

    for path in paths

        if path.length >= 2
            [first, rest...] = path
            for p in path[1..]
                stroke(p.color)
                line first.x, first.y, p.x, p.y
                first = p

        walk(path)














window.setup = setup
window.draw = draw
