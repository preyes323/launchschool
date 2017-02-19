const NewAlbumView = Backbone.View.extend({
  el: 'main',
  template: Handlebars.templates.newAlbum,

  render() {
    this.$el.html(this.template);
  },
});
