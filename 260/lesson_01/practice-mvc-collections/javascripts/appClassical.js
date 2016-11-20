const template = Handlebars.compile($('#cars').html());
function render() {
  $('article').html(template({ cars: inventory.models }));
}

const Car = new ModelConstructor();
const Cars = new CollectionConstructor();
const inventory = new Cars(Car);

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

render();
