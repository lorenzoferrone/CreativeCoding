class Line {
    constructor(c) {
        this.segments = [[]] // lista di liste di punti, ogni lista è un branch della linea
        this.color = c
        this.activeLine = 0
    }

    draw() {
        stroke(this.color)
        strokeCap(ROUND)
        strokeJoin(ROUND)
        strokeWeight(10)
        for (var path of this.segments) {
            noFill()
            beginShape()
            for (var point of path) {
                vertex(point.x, point.y)
            }
            endShape()
        }
        this.drawStation()
    }

    drawStation() {
        for (var path of this.segments) {
            for (var point of path) {
                fill(250, 250, 250)
                stroke(30, 30, 30)
                strokeWeight(2)
                ellipse(point.x, point.y, 20, 20)
            }
        }
    }

    drawSplit() {

    }

    addStation(pos) {
        this.segments[this.activeLine].push(pos)
    }

    addSegment(start, end) {
        this.segments.push({start, end})
    }

}



module.exports = {Line}
