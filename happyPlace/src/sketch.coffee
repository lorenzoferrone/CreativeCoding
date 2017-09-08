# {Grid} = require '../../Utils/Grid'
# {LocalModule} = require './localmodule'

{horizontalLine, circle} = require '../../Utils/positions'
{getPairs, averagePoint} = require '../../Utils/genericUtil'

num_nodes = 200
nodes = []
radius = 300
repulsion = 10
jump = radius
maxFriends = 1000000

color = [100, 100, 100, 1]

updateColor = (color) ->
    if frameCount % 100 == 0
        color[0] = (color[0] + 10) % 255
        color[1] = (color[1] + 20) % 255
        color[2] = (color[2] + 30) % 255
        stroke color

setup =  () ->
    createCanvas windowWidth, windowHeight
    @diagonal = sqrt(windowWidth**2 + windowHeight**2)
    nodes = circle(num_nodes, radius)

    for node in nodes
        node.friends = []
        node.enemies = []

    for [node, othernode] in getPairs(nodes)
        distance = dist(node[0], node[1], othernode[0], othernode[1])
        friendship = map(distance, 0, diagonal, 0.01, 0.001)
        friendship = exp(-distance/30)
        # console.log(friendship)
        # if random() <= 0.8 and node.friends.length <= 10000
        if random() <= friendship
            node.friends.push(othernode)
            # othernode.friends.push(node)
        # else
        #     node.enemies.push(othernode)
        #     othernode.enemies.push(node)

    background 51
    fill color
    stroke color


draw = () ->
    # background(51)

    updateColor color
    # console.log(color)
    # noLoop()
    for node in nodes
        centroid = averagePoint([[node]..., node.friends...])
        d = dist(node[0], node[1], centroid[0], centroid[1])
        if d >= repulsion
            node[0] = lerp(node[0], centroid[0], 0.01)
            node[1] = lerp(node[1], centroid[1], 0.01)

            # node[0] = node[0] + 0.01*(centroid[0] - node[0])
            # node[1] = node[1] + 0.01*(centroid[1] - node[1])

        if 0 < d <= repulsion
            node[0] = node[0] + random(-jump, jump)
            node[1] = node[1] + random(-jump, jump)

        # centroid2 = averagePoint(node.enemies)
        # node[0] = lerp(node[0], centroid2[0], -0.005)
        # node[1] = lerp(node[1], centroid2[1], -0.005)

        # node[0] = node[0] + random(-2, 2)
        # node[1] = node[1] + random(-2, 2)

        # randomCounterX = randomCounterX + 10
        # randomCounterY = randomCounterY + 10

        for othernode in node.friends
            line node[0], node[1], othernode[0], othernode[1]

        # ellipse(node[0], node[1], 1, 1)
        # fill 100, 100, 100, 2
        # ellipse(centroid[0], centroid[1], 1, 1)



mouseClicked = () ->
    console.log mouseX, mouseY
    for node in nodes
        d = distance(node[0], node[1], mouseX, mouseY)
        node[0] = node[0] + (node[0] - mouseX) / distance
        node[1] = node[1] + (node[1] - mouseY) / distance





window.setup = setup
window.draw = draw
window.mouseClicked = mouseClicked
