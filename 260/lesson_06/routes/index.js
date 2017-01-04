var express = require('express');
var router = express.Router();
var _ = require('underscore');

module.exports = function route(app) {
  function setActiveNav(title) {
    const activeItem = _(app.locals.links).findWhere({ active: true });
    if (activeItem) activeItem.active = false;
    _(app.locals.links).findWhere({ title }).active = true;
  }

  const title = 'Home';
  setActiveNav(title);

  router.get('/', function(req, res, next) {
    res.render('index', { title });
  });

  return router;
};
