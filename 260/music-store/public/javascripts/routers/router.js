const Router = Backbone.Router.extend({
  routes: {
    'albums/new': 'newAlbum',
  },

  newAlbum() {
    const newAlbum = new NewAlbumView;
    newAlbum.render();
  },

  index() {
    App.indexView = new IndexView;
    App.indexView.render();
    App.albumsView = new AlbumsView({ collection: App.albums });
    App.albumsView.render();
  },

  initialize() {
    this.route(/^\/?$/, 'index');
  },
});
