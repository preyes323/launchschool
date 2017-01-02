const App = {
  tracks: {},
  albumsLoaded() {
    App.view.render();
  },

  fetchAlbums() {
    this.albums = new Albums;
    App.view = new AlbumsView({ collection: this.albums });
    this.albums.fetch({
      success: this.albumsLoaded.bind(this),
    });
  },

  init() {
    this.fetchAlbums();
  },
};

App.AblumsRouter = new Workspace();
Backbone.history.start({
  pushState: true,
  silent: true,
});

App.init();
