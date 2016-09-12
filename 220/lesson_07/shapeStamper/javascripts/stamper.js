$(document).ready(() => {
  const $buttons = $('.shapeControl');
  const stampPad = $('#stampPad').get(0);
  const ctx = stampPad.getContext('2d');

  const Stamper = {
    stamp: null,
    stampPad: '',

    drawRectangle(x, y, color = '#000') {
      this.stampPad.fillStyle = color;
      this.stampPad.fillRect(x, y, 30, 30);
    },
    drawShape(x, y) {
      switch (this.stamp) {
        case 'square':
          this.drawRectangle(x, y);
          break;
      }
    },
    setStamp(shape) {
      this.stamp = shape.toLowerCase();
    },
    clear() {
      this.stampPad.clearRect(0, 0, this.stampPad.canvas.width, this.stampPad.canvas.height);
    },
    init(canvasCtx) {
      this.stampPad = canvasCtx;
      return this;
    },
  };

  function clearButtons() {
    $buttons.find('a.button').removeClass('active');
  }

  const stamper = Stamper.init(ctx);
  $buttons.on('click.stamper', 'a.button', e => {
    e.preventDefault();
    clearButtons();
    const $button = $(e.target);
    $button.addClass('active');

    if ($button.text() === 'Clear') {
      stamper.clear();
      stamper.setStamp('');
    } else {
      stamper.setStamp($button.text());
    }
  });

  $(stampPad).click(e => {
    const x = e.offsetX;
    const y = e.offsetY;

    console.log('x: ' + x);
    console.log('y: ' + y);
    stamper.drawShape(x, y);
  });

});
