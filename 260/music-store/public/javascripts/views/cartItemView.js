const CartItemView = Backbone.View.extend({
  tagName: 'li',
  template: Handlebars.templates.cartItem,
  events: {
    'click a': 'removeItem',
  },

  initialize() {
    this.model.view = this;
    this.listenTo(this.model, 'destroy', this.remove);
    this.render();
  },

  render() {
    const id = this.model.get('id');
    this.$el.attr('data-id', id);
    this.$el.html(this.template(this.model.attributes));
    return this.el;
  },

  removeItem(e) {
    e.preventDefault();
    this.model.destroy();
  },
});
