getPairs = (array) ->
    pairs = []
    for x, i in array
        for y, j in array
            if j <= i
                continue
            pairs.push [x, y]
    return pairs

averagePoint = (points) ->
    centroid = [0, 0]
    for [x, y] in points
        centroid[0] = centroid[0] + x
        centroid[1] = centroid[1] + y
    return [centroid[0]/points.length, centroid[1]/points.length]


module.exports = {getPairs, averagePoint}
