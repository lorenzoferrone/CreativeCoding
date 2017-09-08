horizontalLine = (numDots) ->
    return (
        [x,
        windowHeight/2] for x in [0 .. windowWidth] by windowWidth/numDots
    )

circle = (numDots, radius) ->
    return (
        [windowWidth/2 + radius*Math.cos(theta),
        windowHeight/2 + radius*Math.sin(theta)] for theta in [0 .. 2*Math.PI] by 2*Math.PI/numDots
    )

module.exports = {horizontalLine, circle}
