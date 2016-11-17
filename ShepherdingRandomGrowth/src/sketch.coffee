# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'
{Dot} = require '../../Utils/dot'
{Graph, Edge} = require './graph'

nodes = []
edges = []

numDots = 50

G = null
radius = 0



setup =  () ->
    createCanvas windowWidth, windowHeight

    dot = new Dot(windowWidth/2 + 50*Math.cos(2*Math.PI/numDots), windowHeight/2 + 50*Math.sin(2*Math.PI/numDots), radius)
    nodes.push dot
    firstDot = dot
    for i in [2 .. numDots]
        newDot = new Dot(windowWidth/2 + 50*Math.cos(i*2*Math.PI/numDots), windowHeight/2 + 50*Math.sin(i*2*Math.PI/numDots), radius)
        nodes.push newDot
        edges.push(new Edge(newDot, dot))
        dot = newDot

    edges.push new Edge(dot, firstDot)

    G = new Graph nodes, edges

    fill 100, 100, 100, 100
    stroke 100, 100, 100, 100
    background 51

draw = () ->
    # background 51

    for dot in G.dots
        # for n in G.near(dot)
        #     dot.attract n.location
        #     # console.log p5.Vector.sub(n.location, dot.location).mag()
        #     if p5.Vector.sub(n.location, dot.location).mag() < 60
        #         dot.repel n.location
        #     dot.move()
        for other in G.dots
            if other != dot
                if G.isNear other, dot
                    dot.attract other.location
                if p5.Vector.sub(other.location, dot.location).mag() < 20
                    dot.repel other.location

                dot.move()

    for edge in G.edges by -1
        {first, second} = edge
        d = p5.Vector.sub(first.location, second.location).mag()
        if d > 30 and G.edges.length < 200
            G.splitEdge edge

    p = random()

    if p > 0.99
        edge = random G.edges
        d = p5.Vector.sub(edge.first.location, edge.second.location).mag()
        if d > 20 and G.edges.length < 200
            G.splitEdge edge


    # d1.attract d2.location
    # d1.move()
    # d1.draw()
    # d2.draw()

    G.draw()
    # console.log G.edges.length, G.dots.length










window.setup = setup
window.draw = draw
