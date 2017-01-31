const fs = require('fs');
const path = require('path');
const _ = require('underscore');

const albumsFilePath = path.resolve(path.dirname(__dirname), 'data/albums.json');

module.exports = function(router) {
  router.updateAlbums = function(albumData, filePath = albumsFilePath) {
    const albums = router.getAlbums(filePath);
    const album = Object.assign({}, albumData);
    album.id = albums.lastId + 1;
    albums.lastId = album.id;
    albums.data.push(album);

    return albums;
  };

  router.recordAlbums = function(albumData, filePath = albumsFilePath) {
    fs.writeFileSync(filePath, JSON.stringify(albumData), 'utf8');
  };

  router.get('/albums/new', function(req, res, next) {
    res.render('new');
  });

  router.post('/albums', function(req, res, next) {
    let albums;
    if (Object.keys(req.body).length > 0) {
      albums = router.updateAlbums(req.body);
      router.recordAlbums(albums.data);
    } else {
      albums = router.getAlbums();
    }

    res.json(_(albums.data).findWhere({ id: albums.lastId }));
  });
};
