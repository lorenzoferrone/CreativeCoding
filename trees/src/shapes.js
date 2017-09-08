const range = (a, b, n=undefined) => {
    if (n == undefined){n = b - a}
    var l = [a]
    for (var i = a; i < b; i = i + (b-a)/n) {
        l.push(i)
    }
    return l
}

const polygonal = (points) => {
    for (var i = 0; i < points.length - 1; i++) {
        const p = points[i] // current point
        const n = points[i + 1] // next point
        line (p[0], p[1], n[0], n[1])
    }
}


// non saprei bene come scalarla
const heart = (numPoints) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            return {
                x: 160 * Math.pow(sin(w), 3),
                y: -(130 * cos(w) - 50 * cos(2*w) - 20*cos(3*w) - 10*cos(4*w))
            }
        }
    )
}

const rose = (numPoints, petal) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            return {
                x: 200 * cos(petal * w) * cos(w),
                y: 200 * cos(petal * w) * sin(w)
            }
        }
    )
}

// devo trovare un modo per calcolare csc ... cercare una libreria di matematica
const swastika = (numPoints) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            return {
                x: 100 * cos(w) * Math.abs(sin(2 * w)),
                y: 100 * cos(w) * sin(w)
            }
        }
    )
}


const maltese = (numPoints) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            const denominator = Math.sqrt(sin(4 * w))
            return {
                x: 10 * cos(w) / denominator,
                y: 10 * sin(w) / denominator
            }
        }
    )
}

const garfield = (numPoints) => {
    return range(-2 * Math.PI, 2*Math.PI, 10*numPoints)
        .map(w => {
            return {
                x: 60 * w * cos(w) * cos(w),
                y: 60 * w * sin(w) * cos(w)
            }
        }
    )
}

const cycloid = (numPoints) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            return {
                x: 100 * cos(w) * (2*cos(2*w) + 1),
                y: 100 * sin(w) * (2*cos(2*w) + 1)
            }
        }
    )
}

const lemniscata = (numPoints) => {
    return range(0, 2*Math.PI, numPoints)
        .map(w => {
            const denominator = sin(w) * sin(w) + 1
            return {
                x: 350 * cos(w) / denominator,
                y: 350 * cos(w) * sin(w) / denominator
            }
        }
    )
}

module.exports = {heart, rose, range, polygonal, maltese, garfield, cycloid, lemniscata}
