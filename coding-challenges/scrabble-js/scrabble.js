(function() {
  var scrabble = function(word) {
    var u = {
      score: function() {
        return scrabble.score(word);
      }
    };

    return u;
  };

  scrabble.score = (function() {
    var CHARACTER_SCORES = { "A": 1, "E": 1, "I": 1, "O": 1, "U": 1, "L": 1, "N": 1, "R": 1,
                             "S": 1, "T": 1, "D": 2, "G": 2, "B": 3, "C": 3, "M": 3, "P": 3,
                             "F": 4, "H": 4, "V": 4, "W": 4, "Y": 4, "K": 5, "J": 8, "X": 8,
                             "Q": 10, "Z": 10 };

    var charScore = function(char) {
      return CHARACTER_SCORES[char];
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
