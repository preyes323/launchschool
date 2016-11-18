function render() {
  $('#make').text(bmw.get('make'));
  $('#model').text(bmw.get('model'));
}

const Car = ModelConstructor({
  change: render,
});

const bmw = Object.create(Car).init({
  make: 'BMW',
  model: '328i',
});


$('form').on('submit', (e) => {
  e.preventDefault();
  const $target = $(e.currentTarget);
  const make = $target.find('[name=make]').val();
  const model = $target.find('[name=model]').val();

  if (make !== bmw.attributes.make) {
    bmw.set('make', make);
  }
  if (model !== bmw.attributes.model) {
    bmw.set('model', model);
  }
});

render();
