const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();

const albums = JSON.parse(fs.readFileSync(path.resolve(path.dirname(__dirname), 'data/albums.json'), 'utf8'));

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Music Store', albums });
});

module.exports = router;
