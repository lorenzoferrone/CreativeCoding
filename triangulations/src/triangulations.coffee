## each function take a list of points and return a list of edges (??)

Array::skipping = (index) ->
    b = @[..]
    b.splice index, 1
    return b

Array::has = (element) ->
    for i in @
        if i == element
            return true
    return false




@nearestNeighbour = (points, n=1, inclusive=true) ->
    edges = []
    for point, index in points
        others = points.skipping index


        others.sort (a, b) ->
            return dist(a.x, a.y, point.x, point.y) - dist(b.x, b.y, point.x, point.y)


        if inclusive is true
            for j in others[...n]
                if not ((edges.has [point, j]) or (edges.has [j, point]))
                    edges.push [point, j]
                else
                    console.log 'already'
        else
            p = others[n - 1]
            if not ((edges.has [point, p]) or (edges.has [p, point]))
                edges.push [point, p]

    return edges
