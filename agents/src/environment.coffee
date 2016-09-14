class Environment
    #a list of entities, each entity should have atleast a location field (PVector)
    constructor: () ->
        @entities = []

    add: (list) ->
        @entities.push.apply(@entities, list)

    push: (element) ->
        @entities.push(element)

    remove: (element) ->
        @entities.splice(@entities.indexOf(element), 1)

    filter: (func) ->
        @entities.filter(func)



module.exports = Environment
