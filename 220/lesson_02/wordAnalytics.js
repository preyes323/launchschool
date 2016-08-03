var paragraph = "In the midway of this our mortal life," +
  "I found me in a gloomy wood, astray" +
  "Gone from the path direct: and e'en to tell" +
  "It were no easy task, how savage wild" +
  "That forest, how robust and rough its growth," +
  "Which to remember only, my dismay" +
  "Renews, in bitterness not far from death." +
  "Yet to discourse of what there good befell," +
  "All else will I relate discover'd there." +
  "How first I enter'd it I scarce can say," +
  "Such sleepy dullness in that instant weigh'd" +
  "My senses down, when the true path I left," +
  "But when a mountain's foot I reach'd, where clos'd" +
  "The valley, that had pierc'd my heart with dread," +
  "I look'd aloft, and saw his shoulders broad"  +
  "Already vested with that planet's beam," +
  "Who leads all wanderers safe through every way.";

function wordAnalytics(text) {
  var textArray = text.replace(/[\.\,\!\?]/ig, '').split(' ');
  var seen = {}
  var mostSeenCount = 0;
  var mostSeen, wordCount;

  textArray.forEach(function(word) {
    var lowerCasedWord = word.toLowerCase();
    seen[lowerCasedWord] = seen[lowerCasedWord] || 0;
    seen[lowerCasedWord] += 1;

    if (seen[lowerCasedWord] > mostSeenCount) {
      mostSeen = lowerCasedWord;
      mostSeenCount = seen[lowerCasedWord];
    };
  });

  wordCount = Object.keys(seen).reduce(function(sum, key) {
    return sum + seen[key];
  }, 0);


  console.table(seen);
  console.log('Total words: ' + wordCount + ', ' + textArray.length);
  console.log('The most seen word is: ' + mostSeen + '.');
  console.log('It was seen ' + mostSeenCount + ' times');
}

wordAnalytics(paragraph);
