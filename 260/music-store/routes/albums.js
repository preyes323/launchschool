const _ = require('underscore');

module.exports = function(router, dataApi) {
  router.post('/albums', function(req, res, next) {
    let albums;
    if (Object.keys(req.body).length > 0) {
      albums = dataApi.set(req.body);
      dataApi.record();
    } else {
      albums = dataApi.tempStore;
    }

    res.json(_(albums.data).findWhere({ id: albums.lastId }));
  });

  router.get('/albums/new', function(req, res, next) {
    res.render('new', {
      albums: dataApi.tempStore.data,
    });
  });
};
