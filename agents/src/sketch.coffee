# coffee -bo ./app -cw ./src/
{Agent, Food}   = require './app/agent.js'
Environment     = require './app/environment.js'

environment = new Environment()
agents      = []
food        = []
maxDistance = 200
foodRate    = 0.1
poisonousFoodRate = 0.1

slow = 0

setup =  () ->
    createCanvas windowWidth, windowHeight
    # frameRate(1)

    for i in [0...5]
        agent = new Agent(random(width), random(height))
        agents.push(agent)

    for i in [0...10]
        f = new Food(random(width), random(height))
        food.push(f)

    environment.add(agents)
    environment.add(food)



mouseClicked = () ->
    if slow == 0
        frameRate(1)
        slow = 1
    else
        frameRate(60)
        slow = 0

draw = () ->

    background 51

    agents  = environment.filter((element) => element instanceof Agent)
    food    = environment.filter((element) => element instanceof Food)

    text("population: #{agents.length}", width - 100, 10, 100, 100)
    text("time: #{(millis()/1000).toFixed(1)}", width - 100, 30, 100, 100)

    if agents.length == 0
        textSize(32)
        textAlign(CENTER)
        text('all dead', width/2 - 250, height/2, 500, 500)
        noLoop()

    r = random()
    p = random()
    if r < foodRate
        f = new Food(random(100, width - 100), random(100, height - 100))
        f.poisonous = p < poisonousFoodRate
        food.push(f)
        environment.push(f)

    for f in food
        f.draw()

    for agent in agents by -1
        agent.health = agent.health - 0.5
        agent.age = agent.age - 0.1
        if (agent.health <= 0) or (agent.age <= 0)
            environment.remove(agent)

        a = agent.reproduce()
        if a isnt undefined
            environment.push(a)

        agent.separate agents
        agent.move environment
        agent.draw()

        for n in food
            distance = dist(agent.location.x, agent.location.y, n.location.x, n.location.y)
            if distance < agent.r/2
                if n.poisonous
                    agent.health = agent.health - 100
                else
                    agent.health = agent.health + 100
                # food.splice(food.indexOf(n), 1)
                environment.remove(n)
