class Cell
    constructor: (@x, @y) ->

    draw: (color) ->
        stroke color
        ellipse @x, @y, 10, 10
        stroke 100, 100, 100, 200


class @Grid
    constructor: (@row, @column) ->
        @sclWidth = floor width /(@row + 1)
        @sclHeight = floor height /(@column + 1)
        @cells = []
        for i in [0 ... @row]
            for j in [0 ... @column]
                @cells.push(new Cell (i+1)*@sclWidth, (j+1)*@sclHeight)
                # ellipse i*@sclWidth, j*@sclHeight, 10, 10


    draw: ->
        for cell in @cells
            # console.log cell
            if cell.selected == true
                c = color 100, 200, 100, 200
            else
                c = color 100, 100, 100, 200
            cell.draw(c)

    get: (x, y) ->
        try
            return @cells[y*@column + x]
        catch
            console.log 'out of bounds'
