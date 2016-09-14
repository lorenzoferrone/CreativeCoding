class @Particle
    constructor: (@x, @y, @vx, @vy, @type, @force) ->
        @nx = @ny = 0
        @nvx = @nvy = 0


    interact: (other) ->
        distance = (@x - other.x)**2 + (@y - other.y)**2
        f = (@force + other.force) / distance

        f = constrain(f, 0, 1700)

        fx = f*(other.x - @x)
        fy = f*(other.y - @y)

        @vx = @vx + fx
        @vy = @vy + fy

    update: () ->
        # @vx = @vx + @nvx
        # @vy = @vy + @nvy

        @x = @x + @vx
        @y = @y + @vy

        # constrain x
        if @x < -3000
            @x = 0
            @vx = 0
            @vy = @vy + random -1, 1

        else if @x > width + 3000
            @x = width
            @vx = 0
            @vy = @vy + random -1, 1

        # constrain y
        if @y < -3000
            @y = 0
            @vy = 0
            @vx = @vx + random -1, 1

        else if @y > height + 3000
            @y = height
            @vy = 0
            @vx = @vx + random -1, 1


        @vx = @vx * 0.5
        @vy = @vy * 0.5
