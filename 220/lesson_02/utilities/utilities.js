(function() {
  var _ = function(elements) {
    var u = {
      first: function() {
        return elements[0];
      },
      last: function() {
        return elements[elements.length - 1];
      },
      without: function() {
        var newArray = [];
        var args = Array.prototype.slice.call(arguments);

        elements.forEach(function(el){
          if (args.indexOf(el) === -1) {
            newArray.push(el);
          };
        });

        return newArray;
      },
      lastIndexOf: function(value) {
        for (var i = elements.length - 1; i >= 0; i--) {
          if (elements[i] === value) {
            return i;
          }
        }

        return -1;
      },
      sample: function(count) {
        var result = [];
        var quantity, randIdx, el;

        if (count) {
          quantity = count;
        } else {
          quantity = 1;
        }

        for (var i = 0; i < quantity; i++) {
          randIdx = Math.floor(Math.random() * elements.length);
          result = result.concat(elements.splice(randIdx, 1));
        }

        return quantity === 1 ? result[0] : result;
      },
      findWhere: function(props) {
        var match;

        elements.some(function(obj) {
          var allMatch = true;

          for (var prop in props) {
            if (!prop in obj || obj[prop] !== props[prop]) {
              allMatch = false;
            }
          }

          if (allMatch) {
            match = obj;
            return allMatch;
          };
        });

        return match;
      },
      where: function(props) {
        return elements.filter(function(obj) {
          return Object.keys(props).some(function(key) {
            return obj[key] === props[key];
          });
        });
      },
      pluck: function(key) {
        return elements.filter(function(obj) {
          return obj[key];
        }).map(function(obj) {
          return obj[key];
        });
      },
      keys: function() {
        var result = [];
        for (var key in elements) {
          if (Object.hasOwnProperty.call(elements, key)) {
            result.push(key);
          };
        }
        return result;
      },
      values: function() {
        var result = [];
        for (var key in elements) {
          if (Object.hasOwnProperty.call(elements, key)) {
            result.push(elements[key]);
          }
        }
        return result;
      },
      pick: function(prop) {
        var newObj = {};
        newObj[prop] = elements[prop];
        return newObj;
      },
      omit: function(prop) {
        var newObj = {}
        delete newObj[prop];
        return newObj;
      },
      has: function(prop) {
        return prop in elements;
      }
    };

    ["isElement", "isArray"].forEach(function(method) {
      u[method] = function() {
        _[method].call(u, elements);
      };
    });

    return u;
  };

  _.range = function(start, stop) {
    var range = [];

    if (!stop) {
      stop = start;
      start = 0;
    }

    for (var i = start; i < stop; i++) {
      range.push(i);
    }

    return range;
  };

  _.extend = function(destination) {
    var objExtenders = Array.prototype.slice.call(arguments).slice(1);

    objExtenders.forEach(function(obj) {
      for (var prop in obj) {
        if (Object.hasOwnProperty.call(obj, prop)) {
          destination[prop] = obj[prop];
        };
      }
    });

    return destination;
  };

  _.isElement = function(obj) {
    return obj.nodeType === 1;
  };
  _.isArray = function()  {};
  _.isObject = function() {};
  _.isFunction = function() {};
  _.isBoolean = function() {};
  _.isString = function() {};
  _.isNumber = function() {};

  window._ = _;
})();
