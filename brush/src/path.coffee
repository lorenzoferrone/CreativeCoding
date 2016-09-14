strokePath = (path) ->
    if path.length > 1
        for index in [0 ... path.length - 1]
            p1 = path[index]
            p2 = path[index + 1]
            [x1, y1] = p1
            [x2, y2] = p2
            randomSeed(x1*y1*x2*y2)
            stroke(250)


            w = 5*random(1, 2)

            strokeWeight(w)
            line(x1, y1, x2, y2)



customLine =  (x1, y1, x2, y2) ->
    ps = [[x1, y1]]
    # norm = sqrt((x1 - x2)^2 + (y1 - y2)^2)
    # console.log norm
    for i in [0 ... 1] by 0.01
        p1 = lerp(x1, x2, i)
        p2 = lerp(y1, y2, i)
        ps.push([p1, p2])
    ps.push([x2, y2])
    strokePath(ps)
    # ellipse(p1, p2, 30, 30)



customLine2 =  (x1, y1, x2, y2) ->
    ps = [[x1, y1]]
    # norm = sqrt((x1 - x2)^2 + (y1 - y2)^2)
    # console.log norm
    v = createVector(x2 - x1, y2 - y1)
    h = v.heading() + PI
    strokeWeight(h)
    line(x1, y1, x2, y2)
    # for i in [0 ... 1] by 0.01
    #     p1 = lerp(x1, x2, i)
    #     p2 = lerp(y1, y2, i)
    #     ps.push([p1, p2])
    # ps.push([x2, y2])
    # strokePath(ps)
    # ellipse(p1, p2, 30, 30)


class @Path
    constructor: () ->
        @path = []

    draw: () ->
        if @path.length > 1
            for index in [0 ... @path.length - 1]
                p1 = @path[index]
                p2 = @path[index + 1]
                [x1, y1] = p1
                [x2, y2] = p2
                stroke(250)

                customLine2(x1, y1, x2, y2)
