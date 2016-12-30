describe('Scrabble', function() {
  it("scores an empty word as zero",function() {
    expect(Scrabble("")).toEqual(0);
  });

  it("scores a null as zero",function() {
    expect(Scrabble(null)).toEqual(0);
  });

  it("scores a very short word",function() {
    expect(Scrabble("a")).toEqual(1);
  });

  it("scores the word by the number of letters",function() {
    expect(Scrabble("street")).toEqual(6);
  });

  it("scores more complicated words with more",function() {
    expect(Scrabble("quirky")).toEqual(22);
  });

  it("scores case insensitive words",function() {
    expect(Scrabble("MULTIBILLIONAIRE")).toEqual(20);
  });
});
