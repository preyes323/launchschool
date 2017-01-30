const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();
const albumsFilePath = path.resolve(path.dirname(__dirname), 'data/albums.json');

router.getAlbums = function() {
  return JSON.parse(fs.readFileSync(albumsFilePath, 'utf8'));
};

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {
    title: 'Music Store',
    albums: router.getAlbums(),
  });
});

module.exports = router;
