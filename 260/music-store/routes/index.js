module.exports = function(router, dataApi) {
  /* GET home page. */
  router.get('/', function(req, res, next) {
    res.render('index', {
      title: 'Music Store',
      albums: dataApi.tempStore.data,
    });
  });
};
