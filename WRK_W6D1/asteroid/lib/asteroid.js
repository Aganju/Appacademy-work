const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');

function Asteroid(pos){
  MovingObject.call(this, {pos: pos, radius: 5, vel: Util.randomVec(50), color: "#00FF00"})

}

Util.inherits(Asteroid, MovingObject);
