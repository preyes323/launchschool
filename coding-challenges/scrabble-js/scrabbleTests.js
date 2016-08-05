var $ol = document.querySelector("ol");

function outputResult(message) {
  var $li = document.createElement("li");
  $li.innerText = message;
  $ol.appendChild($li);
  return $li;
}

function test(message, assertion) {
  var $msg = outputResult(message),
      passed = false;

  try {
    passed = assertion();
  }
  catch (e) {
    passed = false;
  }
  $msg.setAttribute("class", passed ? "pass" : "fail");
}

test("scrabble is defined", function() {
  return typeof scrabble !== "undefied";
});

test("score is defined", function() {
  return typeof scrabble().score === "function";
});

test("Empty word scores zero", function() {
  return scrabble("").score() === 0;
});

test("Whitespace scores zero", function() {
  return scrabble(" \t\n").score() === 0;
});

test("null scores zero", function() {
  return scrabble(null).score() === 0;
});

test("Scores very short word", function() {
  return scrabble("a").score() === 1;
});

test("Scores other very short word", function() {
  return scrabble("f").score() === 4;
});

test("Simple word scores the number of letters", function() {
  return scrabble("street").score() === 6;
});

test("Complicated word scores more", function() {
  return scrabble("quirky").score() === 22;
});

test("Scores are case insensitive", function() {
  return scrabble("OXYPHENBUTAZONE").score();
});

test("Convenient scoring is define", function() {
  return typeof scrabble.score === "function";
});

test("Convenient scoring", function() {
  return scrabble.score("alacrity") === 13;
});
