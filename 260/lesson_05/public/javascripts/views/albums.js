const AlbumsView = Backbone.View.extend({
  el: '#albums',
  render() {
    this.collection.each(function(album) {
      const view = new AlbumView({ model: album });
      this.$el.append(view.render().el);
    }.bind(this));
  },
});
