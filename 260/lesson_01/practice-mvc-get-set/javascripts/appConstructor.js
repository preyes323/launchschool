const template = Handlebars.compile($('#cars').html());
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

$('ul').on('click', 'a', (e) => {
  e.preventDefault();
  const $link = $(e.target);

  inventory.remove(parseInt($link.attr('data-id'), 10));
  $link.closest('li').remove();
});

render();
