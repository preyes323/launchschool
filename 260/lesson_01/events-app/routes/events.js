const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');

const events = JSON.parse(fs.readFileSync(path.join(path.dirname(__dirname), 'data/events.json'), 'utf8'));
const lastId = events[events.length - 1].id;
const urlEncodedParser = bodyParser.urlencoded({ extended: false });

router.get('/', (req, res) => {
  res.json(events);
});

module.exports = router;
