@sample = (array) ->
    array[floor random(0, array.length)]

@polygonal = (points) ->
    for i in [0...points.length-1]
        p = points[i]
        q = points[i+1]
        line p.x, p.y, q.x, q.y
