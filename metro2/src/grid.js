class Grid {
    constructor(distance){
        this.distance = distance
        this.dots = []
        for (var i = this.distance; i <= windowWidth - this.distance; i = i+this.distance) {
            for (var j = this.distance; j <= windowHeight - this.distance; j = j+this.distance) {
                this.dots.push({x: i, y: j})
            }
        }
    }

    nearest(x, y) {
        return this.dots
            .map(dot => {
                return {distance: (x - dot.x)**2 + (y - dot.y)**2, dot: dot}
            })
            .sort( (a, b) => a.distance - b.distance)[0].dot
    }

    draw() {
        for (var dot of this.dots){
            stroke(30, 30, 30, 50)
            fill(100, 100, 100, 50)
            ellipse(dot.x, dot.y, 10, 10)
        }
    }

}



module.exports = {Grid}
