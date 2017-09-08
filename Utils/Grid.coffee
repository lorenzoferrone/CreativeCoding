class Cell
    constructor: (@x, @y) ->
        @color = [100, 100, 100, 100]

    draw: () ->
        stroke @color
        fill @color
        ellipse @x, @y, 10, 10
        # stroke 100, 100, 100, 200


class @Grid
    constructor: (@row, @column) ->
        @sclWidth = floor width /(@row + 1)
        @sclHeight = floor height /(@column + 1)
        @cells = []
        for i in [0 ... @row]
            r = []
            for j in [0 ... @column]
                c = new Cell (i+1)*@sclWidth, (j+1)*@sclHeight
                c.i = i
                c.j = j
                r.push c
                # @cells.push(c)
            @cells.push r


    getNeighbours: (cell) ->
        x = cell.i
        y = cell.j

        N = [@get(x + 1, y),
             @get(x, y + 1),
             @get(x - 1, y),
             @get(x, y - 1)
            #  @get(x + 1, y + 1),
            #  @get(x - 1, y - 1),
            #  @get(x + 1, y - 1),
            #  @get(x - 1, y + 1)
            ]
        N = N.filter((element) -> element != undefined)
        return N
        # return []


    draw: ->
        for row in @cells
            for cell in row
                cell.draw()

    get: (x, y) ->
        try
            return @cells[x][y]
