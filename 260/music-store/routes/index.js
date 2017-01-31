const fs = require('fs');
const path = require('path');
const _ = require('underscore');

const albumsFilePath = path.resolve(path.dirname(__dirname), 'data/albums.json');

module.exports = function(router) {
  router.getAlbums = function(filePath = albumsFilePath) {
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  };

  /* GET home page. */
  router.get('/', function(req, res, next) {
    res.render('index', {
      title: 'Music Store',
      albums: router.getAlbums().data,
    });
  });
};
