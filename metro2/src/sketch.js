var {Grid} = require('./grid')
var {Line} = require('./line')

var grid
var metro
var metros = []
var origin
var path = []
var active = true
var colors
var mode = 'LINE'

var megastations = [[]]



const setup = () => {
    colors = [
        color(245, 130, 31, 200),
        color(66, 103, 178, 200),
        color(12, 247, 5, 200),
        ]
    createCanvas(windowWidth, windowHeight)
    grid = new Grid(20)
    metro = new Line(colors[0])
    metros.push(metro)
    // line = new Line()
    // origin = grid.nearest(windowWidth/2, windowHeight/2)
    // path.push(origin)
}



const draw = () => {
    background(51)
    grid.draw()

    for (var metro of metros){
        metro.draw()
    }

    for (var megastation of megastations){
        stroke(250, 250, 250)
        strokeCap(ROUND)
        strokeJoin(ROUND)
        strokeWeight(10)
        noFill()
        beginShape()
        for (var point of megastation) {
            vertex(point.x, point.y)
        }
        endShape()
    }

        // if (megastation.length == 4) {
        //     [p1, p2] = megastation
        //     strokeCap(ROUND)
        //     strokeJoin(ROUND)
        //     strokeWeight(10)
        //     stroke(250, 250, 250)
        //     line(p1.x, p1.y, p2.x, p2.y)
        // }
        // strokeCap(ROUND)
        // strokeJoin(ROUND)
        // beginShape()
        // for (var p of megastation){
        //     vertex(p.x, p.y)
        // }
        // endShape(CLOSE)
    strokeWeight(1)
    //
}


const touchStarted = () => {
    if (mouseButton == 'left') {
        if (mode == 'LINE'){
            // path.push(grid.nearest(mouseX, mouseY))
            metro.addStation(grid.nearest(mouseX, mouseY))
        }

        else {
            megastations[megastations.length - 1].push(grid.nearest(mouseX, mouseY))
        }
    }
    else {
        if (mode == 'LINE'){
            metro.activeLine++
            metro.segments.push([])
        }
        else {
            megastations.push([])
        }
    }
}

const keyTyped = () => {
    if (key == 'z') {
        // delete last point
        metro.segments[metro.activeLine].pop()
    }

    if (key == 'b') {
        // new line
        metro = new Line(colors[metros.length])
        metros.push(metro)
        metro.segments[metro.activeLine].pop()
    }

    if (key == 's') {
        // draw station mode
        mode = 'STATION'
        console.log('station')
    }

    if (key == 'l') {
        // draw line mode
        mode = 'LINE'
        console.log('line')
    }
}








window.setup = setup
window.draw = draw
window.touchStarted = touchStarted
window.keyTyped = keyTyped
