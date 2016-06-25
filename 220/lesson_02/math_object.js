function radiansToDegrees(radians) {
  return radians * 180 / Math.PI;
}

function positivize(number) {
  return Math.abs(number);
}

function randBetween(low, high) {
  return Math.floor((Math.random() * (high - low + 1)) + low);
}


function repeatThreeTimes() {
  console.log("hello, " + this.first_name + " " + this.last_name);
};

var john = {
  first_name: "John",
  last_name: "Doe",
  greetings: function() {
    var test = repeatThreeTimes.bind(this);
    test();
  }
};

john.greetings();
