const fs = require('fs');
const path = require('path');
const express = require('express');

const router = express.Router();
const routeFiles = ['index', 'albums'];

routeFiles.forEach((route) => {
  require(path.resolve(path.dirname(__dirname), `routes/${route}`))(router);
});

module.exports = router;
