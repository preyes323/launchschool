onmessage = (e) => {
  const digitString = e.data[0];
  const n = e.data[1];
  const digitsProduct = function getDigitsProduct(digits) {
    return digits.split('')
      .map((digit) => parseInt(digit))
      .reduce((total, digit) => total * digit);
  };

  let result = 0;
  let product = 0;
  for (let i = 0, length = digitString.length - n; i < length; i++) {
    product = digitsProduct(digitString.substr(i, n));
    result = result > product ? result : product;
  }

  postMessage(result);
};
