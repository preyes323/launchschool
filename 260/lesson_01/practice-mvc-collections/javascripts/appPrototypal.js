const template = Handlebars.compile($('#cars').html());
function render() {
  $('article').html(template({ cars: inventory.models }));
}

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

$('a').on('click', (e) => {
  e.preventDefault();
  inventory.reset();
  render();
});

$('form').on('submit', (e) => {
  e.preventDefault();
  const $form = $(e.target);
  const properties = {
    make: $form.find('[name=make]').val(),
    model: $form.find('[name=model]').val(),
  };

  inventory.add(properties);
  render();
  e.target.reset();
});

render();
