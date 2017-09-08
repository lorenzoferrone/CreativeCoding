// {Grid} = require '../../Utils/Grid'


var tree = []

class Branch {
    constructor(start, end){
        this.start = start
        this.end = end
    }

    show() {
        line(this.start.x, this.start.y, this.end.x, this.end.y)
    }

    ondulate() {
        this.end.add(random(-1, 1), random(-1, 1))
    }

    bifurcate() {
        const angle = random(PI/4)
        const direction = p5.Vector.sub(this.end, this.start)
        direction.rotate(angle).mult(0.67)

        const rightEnd = p5.Vector.add(this.end, direction)
        const leftEnd = p5.Vector.add(this.end, direction.rotate(-angle*2))

        const right = new Branch(this.end, rightEnd)
        const left = new Branch(this.end, leftEnd)
        return [right, left]
    }
}

const setup = () => {
    createCanvas(windowWidth, windowHeight)
    background(51)
    stroke(100, 100, 100)
    strokeWeight(1)
    const a = createVector(windowWidth / 2, windowHeight)
    const b = createVector(windowWidth / 2, 0.7*windowHeight )
    const root = new Branch(a, b)


    tree.push(root)
    for (var t of tree) {
        if (tree.length <= 1000) {
            tree.push(...t.bifurcate())
        }
    }
    // tree.push(...root.bifurcate())


}



const draw = () => {
    background(51)
    for (var t of tree) {
        t.show()
    }

}



window.setup = setup
window.draw = draw
