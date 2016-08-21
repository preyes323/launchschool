$(document).ready(function() {
  var randomWord = function() {
    var words = ['heterogenous', 'solipsism', 'pulchritude', 'pejorative', 'denigrate', 'corpulence', 'adumbrate',];

    return function() {
      return words.splice(Math.floor(Math.random() * words.length), 1)[0];
    };
  }();

  var Game = {
    maxGuesses: 6,
    guesses: 0,
    word: '',
    guessedWord: '',
    lettersGuessed: [],
    winningMessage: 'Congrats',
    losingMessage: 'Sorry, you ran out of guesses',
    getRandomWord: function() {
      this.word = randomWord();
      if (this.word) {
        this.guessedWord = this.word.replace(/[a-z]/ig, ' ');
      } else {
        this.guessedWord = '';
      }
    },
    guess: function(letterGuessed) {
      var guessedWordArray = this.guessedWord.split('');
      var match;
      if (this.lettersGuessed.indexOf(letterGuessed) >= 0) return;
      this.lettersGuessed.push(letterGuessed);
      this.word.split('').forEach(function(letter, idx) {
        if (letterGuessed === letter) {
          guessedWordArray[idx] = letter;
          match = true;
        }
      });

      if (!match) this.guesses++;
      this.guessedWord = guessedWordArray.join("");
    },
    isGameWon: function() {
      return this.word === this.guessedWord;
    },
    isGameLost: function() {
      return this.guesses >= this.maxGuesses;
    },
    canPlayAgain: function() {
      return !!this.word;
    },
    init: function() {
      this.getRandomWord();
      this.lettersGuessed = [];
      return this;
    },
  };

  function newGame() {
    var currentGame = Object.create(Game).init();
    var $word = $(".word ul");
    var $guesses = $(".guesses ul");

    $word.find("li").remove();
    $guesses.find("li").remove();
    if (currentGame.canPlayAgain()) {
      currentGame.guessedWord.split("").forEach(function(letter) {
        $word.append("<li>" + letter.toUpperCase() + "</li>");
      });

      $(document).off("keypress").on("keypress", function(e) {
        if (e.which >= 97 && e.which <= 122) {
          currentGame.guess(String.fromCharCode(e.which));
          updateDisplay(currentGame.guessedWord, currentGame.lettersGuessed);
        }

        if (currentGame.isGameWon()) {
          $("figcaption").text(currentGame.winningMessage);
          $(document).off("keypress");
        }

        if (currentGame.isGameLost()) {
          $("figcaption").text(currentGame.losingMessage);
          $(document).off("keypress");
        }
      });
    } else {
      $("figcaption").text("Ran out of words!");
    }

    function updateDisplay(guessedWord, lettersGuessed) {
      $word.find("li").remove();
      $guesses.find("li").remove();
      lettersGuessed.forEach(function(letter) {
        $guesses.append("<li>" + letter.toUpperCase() + "</li>");
      });
      guessedWord.split("").forEach(function(letter) {
        $word.append("<li>" + letter.toUpperCase() + "</li>");
      });
    }
  }

  $("a").click(function(e) {
    e.preventDefault();
    $("figcaption").text("");
    newGame();
  });

  newGame();
});
