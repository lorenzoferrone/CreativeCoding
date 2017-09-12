var fs = require('fs')
var {Grid} = require('./grid')
var {Line} = require('./line')


var grid
var paths = []
var drawgrid = true
var transparency = 100


var savebtn

const saved = JSON.parse(fs.readFileSync('./src/saved.json'))
console.log(saved)




const setup = () => {
    c = createCanvas(windowWidth - 250, windowHeight)
    c.parent('c')

    const inp = document.getElementById('input')
    inp.oninput = () => {
        // prima divido con eventuali ":"
        const strokes = inp.value.split(":")
        paths = strokes.map(stroke => stroke.split("").map(letter => grid.get(letter)))
    }

    const s = document.getElementById('save')
    s.onclick = () => {
        console.log(inp.value)
    }
    // inp = createInput('')
    // inp.input(myInput)
    // inp.parent('comandi')
    //
    const t = document.getElementById('toggle')
    t.onclick = () => {
        drawgrid = !drawgrid
        transparency == 100? transparency = 255 : transparency = 100
    }

    //
    // savebtn.parent('comandi')

    grid = new Grid(70)
}


const draw = () => {
    background(151)
    if (drawgrid) grid.draw()
    noFill()
    strokeWeight(25)
    stroke(20, 20, 20, transparency)
    for (var path of paths) {
        beginShape()
        for (dot of path){
            curveVertex(dot.x, dot.y)
        }
        endShape()
    }
    strokeWeight(1)

    //
}


const touchStarted = () => {
}

const keyTyped = () => {
    if (key == 'z') {
        drawgrid = false
        saveCanvas('prova', 'png')
        drawgrid = true
    }

}


// hhrlhnww








window.setup = setup
window.draw = draw
window.touchStarted = touchStarted
window.keyTyped = keyTyped
