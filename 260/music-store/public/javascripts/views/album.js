const AlbumView = Backbone.View.extend({
  tagName: 'li',
  template: Handlebars.templates.album,
  events: {
    'click .btn-add': 'addToCart',
  },

  initialize() {
    this.model.view = this;
    this.render();
  },

  render() {
    const id = this.model.get('id');
    this.$el.attr('data-id', id);
    this.$el.html(this.template(this.model.attributes));
  },

  addToCart(e) {
    e.preventDefault();
    App.cart.addItem(this.model);
  },
});
