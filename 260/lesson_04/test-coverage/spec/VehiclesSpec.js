describe('Vehicle', function() {
  beforeEach(function() {
    this.vehicle = new Vehicle({ make: 'Honda', model: 'Accord' });
  });

  it('sets the make and model properties when an object is passed in', function() {
    expect(this.vehicle.make).toBe('Honda');
    expect(this.vehicle.model).toBe('Accord');
  });

  it('returns concatenated string with make and model', function() {
    expect(this.vehicle.toString()).toBe('Honda Accord');

    this.vehicle.model = 'Civic';
    expect(this.vehicle.toString()).toBe('Honda Civic');
  });

  it('returns a message when the horn is honked', function() {
    expect(this.vehicle.honkHorn()).toMatch(/Beep beep!/);
  });
});
