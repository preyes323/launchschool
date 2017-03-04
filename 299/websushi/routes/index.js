const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/menu-items/menu.json', function(req, res, next) {
  const items = fs.readFileSync(path.resolve(path.dirname(__dirname), 'data/menu.json'));
  res.json(JSON.parse(items));
});

module.exports = router;
