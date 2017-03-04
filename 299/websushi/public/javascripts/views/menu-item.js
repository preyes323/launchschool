const MenuItemView = Backbone.View.extend({
  events: {
    'click button': 'addToCart',
  },

  tagName: 'li',
  template: Handlebars.templates['menu-item'],

  addToCart() {
    App.trigger('add-item', this.model);
  },

  render() {
    this.$el.html(this.template(this.model.toJSON()));
    return this.el;
  },
});
