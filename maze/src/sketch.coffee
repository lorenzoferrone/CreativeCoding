# coffee -bo ./app -cw ./src/
cols = 0
rows = 0
w = 40
grid = []
stack = []
current = null

round_ = (x, n) ->
    a = floor(x/n) * n
    return a

setup =  () ->
    createCanvas round_(windowWidth - 10, w), round_(windowHeight - 10, w)
    cols = floor width/w
    rows = floor height/w

    for j in [0...rows]
        for i in [0...cols]
            cell = new Cell(i, j)
            grid.push(cell)

    current = grid[0]
    # frameRate(5)

draw = () ->
    background(51)
    for cell in grid
        cell.show()

    current.visited = true
    current.highlight()
    n = current.checkNeighbors()
    if n isnt undefined
        n.visited = true
        stack.push(current)
        removeWalls(current, n)
        current = n

    else if stack isnt []
        current = stack.pop()




index = (i, j) ->
    if i < 0 or j < 0 or i > cols-1 or j > rows - 1
        return -1
    i + j*cols

class Cell
    constructor: (@i, @j) ->
        @walls = [true, true, true, true]
        @visited = false

    checkNeighbors: () ->
        neighbors = []

        top = grid[index(@i, @j-1)]
        right = grid[index(@i + 1, @j)]
        bottom = grid[index(@i, @j + 1)]
        left = grid[index(@i - 1, @j)]

        for n in [top, right, bottom, left]
            if n and not n.visited
                neighbors.push n


        if neighbors
            r = floor random(0, neighbors.length)
            return neighbors[r]
        else
            return undefined

    show: () ->
        x = @i*w
        y = @j*w

        stroke(255)

        if @walls[0]
            line(x,     y,     x + w,   y)
        if @walls[1]
            line(x + w, y,     x + w,   y + w)
        if @walls[2]
            line(x + w, y + w, x,       y + w)
        if @walls[3]
            line(x,     y + w, x,       y)


        if @visited
            noStroke()
            fill(255, 0, 255, 20)
            rect(x, y, w, w)

    highlight: () ->
        x = @i*w
        y = @j*w
        noStroke()
        fill(0, 0, 255, 100)
        rect(x, y, w, w)


removeWalls = (a, b) ->
    x = a.i - b.i
    y = a.j - b.j
    if x == 1
        a.walls[3] = false
        b.walls[1] = false
    if x == -1
        a.walls[1] = false
        b.walls[3] = false
    if y == 1
        a.walls[0] = false
        b.walls[2] = false
    if y == -1
        a.walls[2] = false
        b.walls[0] = false
