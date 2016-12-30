function Vehicle(options) {
  this.make = options.make;
  this.model = options.model;
}

Vehicle.prototype.toString = function() {
  return `${this.make} ${this.model}`;
};

Vehicle.prototype.honkHorn = function() {
  return 'Beep beep!';
};
