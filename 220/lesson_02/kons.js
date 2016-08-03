var word = [],
    result = 'enemy';

[0, 2].forEach (function (idx) {

  if (word[idx] !== result.split("")[idx]) {
    console.log(idx)
    word[idx] = result.split("")[idx];
  };
});

console.log(word[2]);
