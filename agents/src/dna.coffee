class DNA
    constructor: (@fitness, @size) ->
        @mutationRate = 0.01
        @genes = []
        for i in [0 ... @size]
            @genes[i] = random()

    crossover: (other) ->
        child = new DNA()
        midpoint = int random(@genes.length)
        for i in [0 ... @genes.length]
            if i < midpoint
                child.genes[i] = @genes[i]
            else
                child.genes[i] = other.genes[i]

        return child

    mutate: () ->
        for i in [0...@genes.length]
            if random() < @mutationRate
                @genes[i] = random 10

    copy: () ->
        a = new DNA(@fitness, @size)
        a.genes = @genes.slice()
        return a

module.exports = DNA
