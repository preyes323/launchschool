const AlbumsCollection = Backbone.Collection.extend({
  model: AlbumModel,
  url: '/albums',
});
