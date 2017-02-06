const fs = require('fs');
const path = require('path');
const express = require('express');

const router = express.Router();
const routeFiles = ['index', 'albums'];

const albumsFilePath = path.resolve(path.dirname(__dirname), 'data/albums.json');
const albumsApi = Object
      .create(require(path.resolve(path.dirname(__dirname), 'api/JSON-RU')))
      .init(albumsFilePath);

routeFiles.forEach((route) => {
  require(path.resolve(path.dirname(__dirname), `routes/${route}`))(router, albumsApi);
});

module.exports = router;
