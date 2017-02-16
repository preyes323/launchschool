const App = {
  $el: $('#albums'),
  renderAlbums() {
    App.albums.each(this.renderAlbum);
  },

  renderAlbum(album) {
    new AlbumView({
      model: album,
    });
  },

  init() {
    this.renderAlbums();
  },
};

Handlebars.partials = Handlebars.templates;
Handlebars.registerHelper('formatDate', function(price) {
  return parseInt(price).toFixed(2);
});
