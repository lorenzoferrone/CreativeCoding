// var {Grid} = require('../../Utils/Grid')
// var {LocalModule} = require('./localmodule')

const setup = () =>
    createCanvas(windowWidth, windowHeight)



const draw = () => {
    ellipse(mouseX, mouseY, 10, 10)
}








window.setup = setup
window.draw = draw
