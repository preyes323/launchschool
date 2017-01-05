const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');

router.get('/', (req, res, next) => {
  const products = fs.readFileSync(path.resolve(path.dirname(__dirname), 'public/products.json'), 'utf-8');
  res.render('index', {
    products: JSON.parse(products),
  });
});

module.exports = router;
