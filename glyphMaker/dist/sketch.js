'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var React = require('react');

var _require = require('react'),
    Component = _require.Component;

var _require2 = require('react-dom'),
    render = _require2.render;

var fs = require('fs');

var _require3 = require('./grid'),
    Grid = _require3.Grid;

var _require4 = require('./line'),
    Line = _require4.Line;

var grid;
var paths = [];
var drawgrid = true;
var transparency = 100;

var saved = {}; //JSON.parse(fs.readFileSync('./src/saved.json'))
console.log(saved);

var toggle = function toggle() {
    drawgrid = !drawgrid;
    transparency == 100 ? transparency = 255 : transparency = 100;
};

var Input_ = function (_Component) {
    _inherits(Input_, _Component);

    function Input_(props) {
        _classCallCheck(this, Input_);

        var _this = _possibleConstructorReturn(this, (Input_.__proto__ || Object.getPrototypeOf(Input_)).call(this, props));

        _this.draw_ = function () {
            var strokes = _this.letter.value.split(":");
            paths = strokes.map(function (stroke) {
                return stroke.split("").map(function (letter) {
                    return grid.get(letter);
                }).filter(function (l) {
                    return l != undefined;
                });
            });
        };

        _this.onChange = function (e) {
            console.log(e);
            var strokes = e.target.value.split(":");
            paths = strokes.map(function (stroke) {
                return stroke.split("").map(function (letter) {
                    return grid.get(letter);
                });
            });
        };

        _this.onClick = function () {
            saved[_this.name.value] = _this.letter.value;
            fs.writeFileSync('./src/saved.json', JSON.stringify(saved));
            _this.forceUpdate();
        };

        return _this;
    }

    _createClass(Input_, [{
        key: 'render',
        value: function render() {
            var _this2 = this;

            var lista = [];
            for (var name in saved) {
                console.log(name, saved[name]);
                lista.push([name, saved[name]]);
            }

            lista = lista.sort(function (a, b) {
                return a[0] >= b[0];
            }).map(function (l) {
                return React.createElement(
                    'div',
                    null,
                    React.createElement(
                        'button',
                        { onClick: function onClick() {
                                _this2.name.value = l[0];
                                _this2.letter.value = l[1];
                                _this2.draw_();
                            } },
                        ' ',
                        l[0],
                        ' '
                    ),
                    React.createElement('br', null)
                );
            });

            return React.createElement(
                'div',
                null,
                React.createElement(
                    'div',
                    null,
                    React.createElement('input', { ref: function ref(input) {
                            _this2.name = input;
                        }, placeholder: 'name' }),
                    React.createElement('input', { ref: function ref(input) {
                            _this2.letter = input;
                        }, onChange: this.onChange }),
                    React.createElement(
                        'button',
                        { onClick: this.onClick },
                        'save'
                    ),
                    React.createElement(
                        'button',
                        { onClick: toggle },
                        'Toggle'
                    )
                ),
                React.createElement('hr', null),
                lista
            );
        }
    }]);

    return Input_;
}(Component);

var App = function (_Component2) {
    _inherits(App, _Component2);

    function App() {
        _classCallCheck(this, App);

        return _possibleConstructorReturn(this, (App.__proto__ || Object.getPrototypeOf(App)).apply(this, arguments));
    }

    _createClass(App, [{
        key: 'render',
        value: function render() {
            return React.createElement(
                'div',
                null,
                React.createElement(Input_, null)
            );
        }
    }]);

    return App;
}(Component);

render(React.createElement(App, null), document.getElementById('root'));

var setup = function setup() {
    var c = createCanvas(windowWidth - 250, windowHeight);
    c.parent('c');
    grid = new Grid(70);
};

var draw = function draw() {
    background(151);
    if (drawgrid) grid.draw();
    noFill();
    strokeWeight(35);
    stroke(20, 20, 20, transparency);
    var _iteratorNormalCompletion = true;
    var _didIteratorError = false;
    var _iteratorError = undefined;

    try {
        for (var _iterator = paths[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
            var path = _step.value;

            beginShape();
            var _iteratorNormalCompletion2 = true;
            var _didIteratorError2 = false;
            var _iteratorError2 = undefined;

            try {
                for (var _iterator2 = path[Symbol.iterator](), _step2; !(_iteratorNormalCompletion2 = (_step2 = _iterator2.next()).done); _iteratorNormalCompletion2 = true) {
                    var dot = _step2.value;

                    curveVertex(dot.x, dot.y);
                }
            } catch (err) {
                _didIteratorError2 = true;
                _iteratorError2 = err;
            } finally {
                try {
                    if (!_iteratorNormalCompletion2 && _iterator2.return) {
                        _iterator2.return();
                    }
                } finally {
                    if (_didIteratorError2) {
                        throw _iteratorError2;
                    }
                }
            }

            endShape();
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

    strokeWeight(1);

    //
};

var touchStarted = function touchStarted() {};

var keyTyped = function keyTyped() {
    if (key == 'z') {
        drawgrid = false;
        saveCanvas('prova', 'png');
        drawgrid = true;
    }
};

// hhrlhnww


window.setup = setup;
window.draw = draw;
window.touchStarted = touchStarted;
window.keyTyped = keyTyped;