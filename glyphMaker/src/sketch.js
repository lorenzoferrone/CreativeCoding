var React = require('react')
var {Component} = require('react')
var {render} = require('react-dom')


var fs = require('fs')
var {Grid} = require('./grid')
var {Line} = require('./line')

var grid
var paths = []
var drawgrid = true
var transparency = 100



var saved = {} //JSON.parse(fs.readFileSync('./src/saved.json'))
console.log(saved)

const toggle = () => {
    drawgrid = !drawgrid
    transparency == 100? transparency = 255 : transparency = 100
}

class Input_ extends Component {

    constructor(props){
        super(props)
    }

    draw_ = () => {
        const strokes = this.letter.value.split(":")
        paths = strokes.map(stroke => stroke.split("").map(letter => grid.get(letter)).filter(l => l != undefined))
    }

    onChange = (e) => {
        console.log(e)
        const strokes = e.target.value.split(":")
        paths = strokes.map(stroke => stroke.split("").map(letter => grid.get(letter)))
    }

    onClick = () => {
        saved[this.name.value] = this.letter.value
        fs.writeFileSync('./src/saved.json', JSON.stringify(saved))
        this.forceUpdate()
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
                    <button onClick={toggle}>{'Toggle'}</button>
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
    const c = createCanvas(windowWidth - 250, windowHeight)
    c.parent('c')
    grid = new Grid(70)
}


const draw = () => {
    background(151)
    if (drawgrid) grid.draw()
    noFill()
    strokeWeight(35)
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
