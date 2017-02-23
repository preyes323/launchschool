const CartItems = Backbone.Collection.extend({
  initialize() {
    this.on('add change:quantity', this.calculateTotals);
    this.cartTotal = 0;
    this.cartQuantity = 0;
  },

  addItem(album) {
    const item = this.findWhere({ id: album.id }) || album.clone();
    if (item.has('quantity')) {
      item.set('quantity', Number(item.get('quantity')) + 1);
    } else {
      item.set('quantity', 1);
      this.add(item);
    }
  },

  calculateTotals() {
    this.cartTotal = this.reduce(function(total, item) {
      return total + (Number(item.get('quantity')) * Number(item.get('price')));
    }, 0);

    this.cartQuantity = this.reduce(function(total, item) {
      return total + Number(item.get('quantity'));
    }, 0);
    console.log(this.cartTotal, this.cartQuantity);
  },
});
