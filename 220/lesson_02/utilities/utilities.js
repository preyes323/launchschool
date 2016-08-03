(function() {
  var _ = function(element) {
    var u = {
      first: function() {
        return element[0];
      }
    };

    return u;
  };

  window._ = _;
})();
