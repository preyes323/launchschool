(function() {
  var scrabble = function(word) {
    var u = {
      score: function() {
        return scrabble["score"].call(u, word);
      }
    };

    return u;
  };

  scrabble.score = (function() {
    var CHARACTER_SCORES = { "AEIOULNRST": 1, "DG": 2,
                             "BCMP": 3, "FHVWY": 4, "K": 5,
                             "JX": 8, "QZ": 10 };

    var charScore = function(char) {
      return CHARACTER_SCORES[lookupKey(char)];
    };

    var lookupKey = function(char) {
      for (var key in CHARACTER_SCORES) {
        if (key.indexOf(char.toUpperCase()) >= 0) {
          return key;
        };
      }
    };

    return function(word) {
      if (!word) {
        return 0;
      }

      return word.toUpperCase().replace(/[^A-Z]/g, "").split("").reduce(function(total, char) {
        return total + charScore(char);
      }, 0);
    };
  })();

  window.scrabble = scrabble;
})();
