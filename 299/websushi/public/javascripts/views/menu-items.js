const Menu = Backbone.View.extend({
  tagName: 'ul',
  render() {
    this.collection.each((model) => {
      const itemView = new MenuItemView({ model });
      this.$el.append(itemView.render());
    });

    return this.el;
  },

  initialize() {
    this.$el.addClass('menu-item');
  },
});
