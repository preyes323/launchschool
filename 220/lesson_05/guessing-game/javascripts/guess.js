$(document).ready(function() {
  var randomWord = function() {
    var words = ['heterogenous', 'solipsism', 'pulchritude', 'pejorative', 'denigrate', 'corpulence', 'adumbrate',];

    return function() {
      return words.splice(Math.floor(Math.random() * words.length), 1)[0];
    };
  }();

  var Game = {
    maxGueses: 6,
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
      return this.guesses < this.maxGuesses;
    },
    canPlayAgain: function() {
      return !!this.word;
    },
  };

  function newGame() {
    var currentGame = Object.create(Game);
    var $word = $(".word ul");
    var $guesses = $(".guesses ul");

    currentGame.getRandomWord();
    $word.find("li").remove();
    if (currentGame.canPlayAgain()) {
      currentGame.guessedWord.split('').forEach(function(char) {
        $word.append("<li>" + char.toUpperCase() + "</li>");
      });

      $(document).off("keypress").on("keypress", function(e) {
        if (e.which >= 97 && e.which <= 122) {
          currentGame.guess(String.fromCharCode(e.which));
          console.log(currentGame);
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
  }

  $("a").click(function(e) {
    e.preventDefault();
    newGame();
  });

  newGame();
});
