const AlbumsView = Backbone.View.extend({
  el: 'main',

  render() {
    this.collection.each(this.renderAlbum.bind(this));
  },

  renderAlbum(album) {
    const albumView = new AlbumView({
      model: album,
    });

    this.$('ul').append(albumView.el);
  },
});
