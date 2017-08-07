function sum() {
  const args =  Array.prototype.slice.call(arguments);
  let sum = 0;
  args.forEach((el) => {sum += el;});
  console.log(sum);
}

function splatSum(...args){
  let sum = 0;
  args.forEach((el) => {sum += el;});
  console.log(sum);
}




Function.prototype.myBind = function(context){
  const args = Array.prototype.slice.call(arguments, 1);
  const self = this;
  return function() {
    self.apply(context, args.concat(Array.from(arguments))); };
};

Function.prototype.mySplatBind = function(context, ...bindArgs){
  return (...callArgs) => { this.apply(context, bindArgs.concat(callArgs)); };
};


function curriedSum(numArgs){
  const numbers = [];
  return function _curriedSum(num){
    numbers.push(num);
    if (numbers.length === numArgs){
      let sum = 0;
      numbers.forEach( (e) => { sum += e; });
      return sum;
    }
    else {
      return _curriedSum;
    }
  }

}




Function.prototype.curry = function(numArgs){
  const args = [];
  self = this;
  return function _curry(arg){
    args.push(arg);
    if (args.length === numArgs){
      self.apply(self, args);
    }
    else {
      return _curry;
    }
  }
};

Function.prototype.splatCurry = function(numArgs){
  const args = [];
  self = this;
  return function _curry(arg){
    args.push(arg);
    if (args.length === numArgs){
      self(...args);
    }
    else {
      return _curry;
    }
  }
}
