{Dot} = require '../../Utils/dot'


class Edge
    constructor: (@first, @second) ->

    draw: () ->
        line @first.location.x, @first.location.y, @second.location.x, @second.location.y

class Graph
    constructor: (@dots, @edges) ->


    draw: () ->
        for dot in @dots
            dot.draw()

        for edge in @edges
            edge.draw()

    near: (dot) ->
        n = []
        for edge in @edges
            if edge.second == dot
                n.push edge.first
            if edge.first == dot
                n.push edge.second
        return n
        # (edge.second for edge in @edges if edge.first == dot).concat (edge.first for edge in @edges if edge.second == dot)

    isNear: (dot, other) ->
        for edge in @edges
            if (edge.first == dot and edge.second == other) or (edge.second == dot and edge.first == other)
                return true
        return false

    addEdge: () ->


    splitEdge: (edge) ->
        {first, second} = edge
        midPoint = new Dot (first.location.x + second.location.x)/2, (first.location.y + second.location.y)/2, first.r
        new1 = new Edge(first, midPoint)
        new2 = new Edge(midPoint, second)
        @edges.push new1
        @edges.push new2
        @dots.push midPoint
        @edges.splice(@edges.indexOf(edge), 1)



module.exports = {Graph, Edge}
