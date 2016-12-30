describe('Honda', function() {
  beforeEach(function() {
    this.honda = new Honda('Accord');
  });

  it('inherits the Vehicle prototype', function() {
    expect(this.honda.toString()).toBe('Honda Accord');
  });
});
