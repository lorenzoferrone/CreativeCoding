var React = require('react')
var {Component} = require('react')
var {render} = require('react-dom')

var canvasBuffer = require('electron-canvas-to-buffer')
const {clipboard} = require('electron')
const {nativeImage} = require('electron')


var fs = require('fs')
var {Grid} = require('./grid')
var {Line} = require('./line')

var grid
var paths = []
var drawgrid = true
var transparency = 100
var back = 151

var c



var saved = JSON.parse(fs.readFileSync('./src/saved.json'))

const toggle = () => {
    drawgrid = !drawgrid
    transparency == 100? transparency = 255 : transparency = 100
    // back == 151? back = 255 : back = 151
}

class Input_ extends Component {

    constructor(props){
        super(props)
    }

    draw_ = () => {
        const strokes = this.letter.value.split(":")
        paths = strokes.map(
            stroke => stroke.split("").map(
                letter => grid.get(letter)
            ).filter(l => l != undefined)
        )

        console.log()
    }

    onChange = (e) => {
        this.draw_()
    }

    onClick = () => {
        saved[this.name.value] = this.letter.value
        fs.writeFileSync('./src/saved.json', JSON.stringify(saved))
        this.forceUpdate()
    }

    copy = () => {
        var buffer = canvasBuffer(c.elt, 'image/png')
        clipboard.writeImage(nativeImage.createFromBuffer(buffer))
    }

    render() {

        var lista = []
        for (var name in saved) {
            console.log(name, saved[name])
            lista.push([name, saved[name]])
        }


        lista = lista.sort((a, b) => a[0] >= b[0] ).map(l => {
            return (<div><button onClick={() => {
                this.name.value = l[0]
                this.letter.value = l[1]
                this.draw_()
            }}> {l[0]} </button><br /></div>
        )})


        return (
            <div>
                <div>
                    <input ref={(input) => { this.name = input; }} placeholder={'name'} />
                    <input ref={(input) => { this.letter = input; }} onChange={this.onChange}/>
                    <button onClick={this.onClick}>{'save'}</button>
                    <button onClick={toggle}>{'Toggle Grid'}</button>
                    <button onClick={this.copy}> {'Copy'}</button>
                </div>
                <hr />
                {lista}

            </div>
        )
    }
}


class App extends Component {
    render() {
        return (
            <div>
                <Input_ />
            </div>
        )
    }
}



render(
    <App />,
    document.getElementById('root')
);




const setup = () => {
    c = createCanvas(windowWidth - 250, windowHeight)
    c.parent('c')
    grid = new Grid(140)
}


const draw = () => {
    background(back)
    if (drawgrid) grid.draw()
    noFill()
    strokeWeight(60)
    stroke(20, 20, 20, transparency)
    for (var path of paths) {
        beginShape()
        for (var dot of path){
            curveVertex(dot.x, dot.y)
        }
        endShape()
    }
    strokeWeight(1)

    //
}


// const touchStarted = () => {
// }
//
// const keyTyped = () => {
//     if (key == 'z') {
//
//         drawgrid = false
//         saveCanvas('prova', 'png')
//         drawgrid = true
//     }
//
// }


// hhrlhnww








window.setup = setup
window.draw = draw
