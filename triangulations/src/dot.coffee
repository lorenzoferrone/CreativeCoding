class @Dot
    constructor: (@x, @y) ->
        @pos = createVector @x, @y
        @velocity = createVector (random -2, 2), (random -2, 2)

        @id = (0|Math.random()*9e6).toString(36)
        console.log @id


    move: () ->

        nx = noise @x
        ny = noise @y

        @x = @x + @velocity.x
        @y = @y + @velocity.y

        # @x = @x + random -1, 1
        # @y = @y + random -1, 1

        if @x >= width
            @x = width - 10
            @velocity.x *= -1
            # @x = width

        if @x <= 0
            @x = 10
            @velocity.x *= -1

        if @y >= height
            @y = height - 10
            @velocity.y *= -1

        if @y <= 0
            @y = 10
            @velocity.y *= -1
