# coffee -bo ./app -cw ./src/


average = (list) ->
    total = 0
    for element in list
        console.log element
        if element is undefined
            continue
        total = total + element
    return total / list.length


keyTyped = () ->
    if key == 'p'
        noLoop()


setup =  () ->
    createCanvas windowWidth, windowHeight
    @precision = 3
    @line = []
    @lines = [@line]
    @i = 0
    return 0

draw = () ->
    background 51
    stroke 200
    strokeWeight 1
    noFill()

    [..., last, current] = lines
    if last is undefined
        for j in [1 .. 10]   #speedup
            current.push(map(noise(i/30), 0, 1, -20, 20))
            i++

    else
        for j in [1 .. 100]   #speedup
            # map(noise(), 0, 1, -1, 1
            s = max(0, i-1)
            direction = average(last[s .. i+1])
            # console.log 'd', i, direction
            current.push(direction + random(0, 1))
            # current.push(last[i] + random(-1, 1))
            i++

    if current.length > height
        lines.push([])
        @i = 0
        # [..., @line] = lines

    for l, nlines in lines
        beginShape()
        for element, index in l
            vertex(element + 4*(nlines + 10), precision*index)
        endShape()
