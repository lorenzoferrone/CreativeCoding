"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Grid = function () {
    function Grid(distance) {
        _classCallCheck(this, Grid);

        var alphabet = 'abcdefghijklmnopqrstuvwxyz'.split("");
        this.distance = distance;
        var N = 4;
        this.dots = [];
        var k = 0;
        for (var i = 0; i <= N; i++) {
            for (var j = 0; j <= N; j++) {
                this.dots.push({
                    label: alphabet[k],
                    x: j * this.distance + width / 2 - this.distance * N / 2,
                    y: i * this.distance + height / 2 - this.distance * N / 2
                });
                k++;
            }
        }
    }

    _createClass(Grid, [{
        key: "nearest",
        value: function nearest(x, y) {
            return this.dots.map(function (dot) {
                return { distance: Math.pow(x - dot.x, 2) + Math.pow(y - dot.y, 2), dot: dot };
            }).sort(function (a, b) {
                return a.distance - b.distance;
            })[0].dot;
        }
    }, {
        key: "get",
        value: function get(label) {
            return this.dots.filter(function (dot) {
                return dot.label == label;
            })[0];
        }
    }, {
        key: "draw",
        value: function draw() {
            var _iteratorNormalCompletion = true;
            var _didIteratorError = false;
            var _iteratorError = undefined;

            try {
                for (var _iterator = this.dots[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
                    var dot = _step.value;

                    stroke(30, 30, 30, 50);
                    // fill(100, 100, 100, 50)
                    noFill();
                    ellipse(dot.x, dot.y, 40, 40);
                    fill(0);
                    text(dot.label, dot.x, dot.y);
                }
            } catch (err) {
                _didIteratorError = true;
                _iteratorError = err;
            } finally {
                try {
                    if (!_iteratorNormalCompletion && _iterator.return) {
                        _iterator.return();
                    }
                } finally {
                    if (_didIteratorError) {
                        throw _iteratorError;
                    }
                }
            }
        }
    }]);

    return Grid;
}();

module.exports = { Grid: Grid };