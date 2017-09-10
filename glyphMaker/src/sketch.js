var {Grid} = require('./grid')
var {Line} = require('./line')

var grid
var path = []
var inp
var drawgrid = true



const setup = () => {
    createCanvas(windowWidth, windowHeight - 40)
    inp = createInput('')
    inp.input(myInput)
    grid = new Grid(70)
}


const myInput = () => {
    const s = inp.value().split("")
    path = s.map(letter => grid.get(letter))
    // for (letter of s){
    //
    //     const dot = grid.get(letter)
    //     path.push(dot)
    // }

}


const draw = () => {
    background(151)
    if (drawgrid) grid.draw()
    noFill()
    beginShape()
    strokeWeight(5)
    stroke(20, 20, 20, 100)
    for (dot of path){
        curveVertex(dot.x, dot.y)
    }
    endShape()
    strokeWeight(1)

    //
}


const touchStarted = () => {
}

const keyTyped = () => {
    if (key == 'g') {
        drawgrid = !drawgrid
    }

}


// hhrlhnww








window.setup = setup
window.draw = draw
window.touchStarted = touchStarted
window.keyTyped = keyTyped
