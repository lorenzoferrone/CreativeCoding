class Grid {
    constructor(distance){
        const alphabet = 'abcdefghijklmnopqrstuvwxyz'.split("")
        this.distance = distance
        var N = 4
        this.dots = []
        var k = 0
        for (var i = 0; i <= N; i++) {
            for (var j = 0; j <= N; j++) {
                this.dots.push({
                    label: alphabet[k],
                    x: j * this.distance + (windowWidth / 2) - (this.distance * N / 2),
                    y: i * this.distance + (windowHeight / 2) - (this.distance * N / 2),
                })
                k++
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

    get(label) {
        return this.dots.filter(dot => dot.label == label)[0]
    }

    draw() {
        for (var dot of this.dots){
            stroke(30, 30, 30, 50)
            // fill(100, 100, 100, 50)
            noFill()
            ellipse(dot.x, dot.y, 40, 40)
            fill(0)
            text(dot.label, dot.x, dot.y)
        }
    }

}



module.exports = {Grid}
