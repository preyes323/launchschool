const CartView = Backbone.View.extend({
  template: Handlebars.templates.cart,
  initialize() {
    this.listenTo(this.collection, 'change:quantity', this.update);
    this.listenTo(this.collection, 'add', this.addItem);
    this.$header = $('main > header');
    this.render();
  },

  render() {
    const total = this.collection.cartTotal;
    const quantity = this.collection.cartQuantity;

    this.$el.addClass('cart');
    this.$el.html(this.template({ cartTotal: total, cartQuantity: quantity }));
    this.$header.append(this.el);
  },

  formatQuantity(quantity) {
    let msg;
    if (quantity > 1) {
      msg = `${quantity} items`;
    } else {
      msg = `${quantity} item`;
    }

    return msg;
  },

  update() {
    this.$('label').text(this.formatQuantity(this.collection.cartQuantity));
    this.$('p').text(`$${this.collection.cartTotal.toFixed(2)}`);
  },

  addItem(item) {
    this.$items = this.$items || $('.items ul');
    const itemView = new CartItemView({ model: item });
    this.$items.append(itemView.render());
    this.update();
  },
});
