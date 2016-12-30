const App = {
  albumsLoaded() {},

  fetchAlbums() {
    this.albums = new Albums;
    this.albums.fetch({
      success: this.albumsLoaded.bind(this),
    });
  },

  init() {
    this.fetchAlbums();
  },
};
