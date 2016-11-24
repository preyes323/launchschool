const template = Handlebars.compile($('#cars').html());
const Car = ModelConstructor();
const Cars = CollectionConstructor();
const inventory = Cars.init(Car);

inventory.add({
  make: 'BMW',
  model: '328i',
});
inventory.add({
  make: 'Mini',
  model: 'Cooper',
});
inventory.add({
  make: 'Lotus',
  model: 'Elise',
});

function render() {
  $('ul').html(template({ cars: inventory.models }));
}

$('a').on('click', (e) => {
  e.preventDefault();
  inventory.reset();
  render();
});

$('form').on('submit', function submit(e) {
  e.preventDefault();
  const $form = $(this);
  const properties = {
    make: $form.find('[name=make]').val(),
    model: $form.find('[name=model]').val(),
  };

  inventory.add(properties);
  render();
  this.reset();
});

$('ul').on('click', 'a', function removeModel(e) {
  e.preventDefault();
  const $link = $(this);

  inventory.remove(parseInt($link.attr('data-id'), 10));
  $link.closest('li').remove();
});

render();
