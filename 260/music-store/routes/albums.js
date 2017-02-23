const _ = require('underscore');

module.exports = function(router, dataApi) {
  router.route('/albums/:id')
    .get(function(req, res, next) {
      res.json(dataApi.tempStore.data);
    })
    .delete(function(req, res, next) {
      const id = req.params.id;
      dataApi.delete(id);
      dataApi.record();
      res.status(200).end();
    });

  router.route('/albums')
    .get(function(req, res, next) {
      res.json(dataApi.tempStore.data);
    })
    .post(function(req, res, next) {
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
