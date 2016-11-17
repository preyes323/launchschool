const Car = ModelConstructor({
  change: render,
});
const  bmw = new Car({
  make: 'BMW',
  model: '328i',
});

function render() {
  $('#make').text(bmw.get('make'));
  $('#model').text(bmw.get('model'));
}

render();

$('form').on('submit', function(e) {
  e.preventDefault();
  var make = $(this).find('[name=make]').val(),
      model = $(this).find('[name=model]').val();

  if (make !== bmw.attributes.make) {
    bmw.set('make', make);
  }
  if (model !== bmw.attributes.model) {
    bmw.set('model', model);
  }
});
