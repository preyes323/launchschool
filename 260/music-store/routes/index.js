const express = require('express');
const fs = require('fs');
const path = require('path');
const _ = require('underscore');

const router = express.Router();
const albumsFilePath = path.resolve(path.dirname(__dirname), 'data/albums.json');

router.getAlbums = function(filePath = albumsFilePath) {
  const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  const lastId = parseInt(data[data.length - 1].id, 10);
  return { data, lastId };
};

router.updateAlbums = function(albumData, filePath = albumsFilePath) {
  const albums = router.getAlbums(filePath);
  const album = Object.assign({}, albumData);
  album.id = albums.lastId + 1;

  albums.data.push(album);
  albums.lastId = album.id;
  return albums;
};

router.recordAlbums = function(albumData, filePath = albumsFilePath) {
  fs.writeFileSync(filePath, JSON.stringify(albumData), 'utf8');
};

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {
    title: 'Music Store',
    albums: router.getAlbums().data,
  });
});

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

module.exports = router;
