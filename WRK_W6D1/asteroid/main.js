const Util = require('./lib/utils.js');
const MovingObject = require('./lib/moving_object.js');
const MovingObject = require('./lib/asteroid.js');


const canvasEl = document.getElementsByTagName("canvas")[0];
canvasEl.height = window.innerHeight;
canvasEl.width = window.innerWidth;

Window.prototype.MovingObject = MovingObject;
Window.Util = Util;
Window.canvasEl = canvasEl
