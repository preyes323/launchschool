function Honda(model) {
  try {
    if (this.verify(model)) {
      this.model = model;
      this.make = 'Honda';
    } else {
      throw new Error;
    }
  } catch (e) {
    console.log(`Model ${this.model} does not exist`);
    return;
  }
}

 Honda.prototype = Vehicle.prototype;

Honda.prototype.verify = function(model) {
  return this.models.includes(model);
};

Honda.prototype.models = ['Accord', 'Civic', 'Crosstour', 'CR-V', 'CR-Z', 'Fit', 'HR-V', 'Insight', 'Odyssey', 'Pilot'];

Honda.prototype.prices = [16500, 14500, 21000, 15800, 12000, 13100, 16000, 18100, 22500, 19300];

Honda.prototype.getPrice = function(model) {
  return this.prices[this.models.indexOf(model)];
};

Honda.prototype.getModels = function() {
  return this.models;
};
