const AlbumView = Backbone.View.extend({
  tagName: 'li',
  template: Handlebars.compile($('#album').html()),

  render() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },

  initialize() {
    this.listenTo(this.model, 'change', this.render.bind(this));
  },
});
