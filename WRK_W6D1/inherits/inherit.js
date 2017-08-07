Function.prototype.inherits = function(parent){
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
}


function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);


MovingObject.prototype.move = (direction) => { console.log(`Moving in the ${direction} direction`); };
Asteroid.prototype.crash = () => { console.log(`Crashing`); };
Ship.prototype.fire = () => { console.log(`Firing`); };


s = new Ship
a = new Asteroid

s.move('right')
a.move('left')

a.crash();
s.fire();

s.crash();
a.fire();
