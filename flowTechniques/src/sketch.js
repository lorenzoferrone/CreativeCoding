// {Grid} = require '../../Utils/Grid'
const {heart, rose, maltese, garfield, cycloid, lemniscata,
    range, polygonal} = require('./shapes')

// var initialization
var P1, P2, P3, P1_n, P2_n, prob

// particle class
class Particle {
    constructor(x, y) {
        this.x = x
        this.y = y
        this.dx = random(-1, 1)
        this.dy = random(-1, 1)
        this.accx = 0
        this.accy = 0
        this.force = 0.95
        this.speed = 0.5
        this.target = random(P1)
        this.trace = []
        this.traceLength = 50
        this.color = [random(100, 255), 30, 30, 100]

    }

    move() {
        this.dx = this.dx + this.accx
        this.dy = this.dy + this.accy
        this.x = this.x + this.dx
        this.y = this.y + this.dy
        this.accx = 0
        this.accy = 0
    }

    applyForce(fx, fy) {
        this.accx = this.accx + fx
        this.accy = this.accy + fy
    }

    draw() {
        fill(this.color)
        stroke(this.color)
        ellipse(this.x, this.y, 1, 1)
        if (this.trace.length > this.traceLength) {
            this.trace = this.trace.slice(-this.traceLength)
        }
        this.trace.push([this.x, this.y])
        // noFill()
        // for (var p of this.trace) {
        //     vertex(p[0], p[1])
        //     ellipse(p[0], p[1], 5, 5)
        // }

        polygonal(this.trace)
    }

    followTarget(x, y) {

        // compute distance
        const dist_x = this.x - x
        const dist_y = this.y - y

        const distance = Math.sqrt(dist_x * dist_x + dist_y * dist_y)

        if (distance < 10) {
            if (random() > prob) {
                this.target = random(P1)
            }
            else {
                this.target = P1[(P1.indexOf(this.target) + 1) % P1.length]
            }
        }

        this.dx = this.dx + (- dist_x / distance * this.speed)
        this.dy = this.dy + (- dist_y / distance * this.speed)

        this.dx = this.dx * this.force
        this.dy = this.dy * this.force
        this.move()

    }


    followTarget2(x, y) {
        const dist_x = this.x - x
        const dist_y = this.y - y


        const distance = Math.sqrt(dist_x * dist_x + dist_y * dist_y)

        // if (distance < 10) {
        //     if (random() > 0.95) {
        //         this.target = random(P3)
        //     }
        // }
        const fx = -3000 * dist_x / (distance * distance * distance)
        const fy = -3000 * dist_y / (distance * distance * distance)

        this.applyForce(fx, fy)
        console.log (this.accx, this.accy)
    }
}








const setup =  () => {
    createCanvas(windowWidth, windowHeight)
    background(60)
    stroke(200, 30, 30, 50)

    P1_n = 300 // shape
    P2_n = 100 // particles
    prob = 0.99

    // starting points (shape)
    // P1 = heart(P1_n)
    P1 = lemniscata(P1_n)
    // target points
    P3 = JSON.parse(JSON.stringify(P1));
    // particles
    P2 = range(1, P2_n)
        .map(x => new Particle(random(-100, 100), random(-100, 100)))

}

const draw = () => {

    translate(windowWidth/2, windowHeight/2)

    background(200)

    const scale =  1 //* (cos(frameCount / 100)/2 + 1)


    //  P3 è la forma originale di riferimento,
    //  P1 viene modificata, le particelle inseguono P1
    for (var i = 0; i < P3.length; i++) {
        let x = scale * P3[i].x
        let y = scale * P3[i].y

        P1[i].x = x
        P1[i].y = y

    }

    P2.forEach(particle => {
        particle.followTarget(
            particle.target.x,
            particle.target.y
        )
        particle.move()
        particle.draw()
    })
}








window.setup = setup
window.draw = draw
