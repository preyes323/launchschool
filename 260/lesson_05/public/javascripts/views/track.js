const TrackView = Backbone.View.extend({
  tagName: 'tr',
  template: Handlebars.compile($('#track').html()),
  render() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },
});
