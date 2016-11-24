const Car = ModelConstructor();
const Cars = CollectionConstructor();
const CarView = ViewConstructor({
  tagName: 'li',
  template: Handlebars.compile($('#cars').html()),
});
const $cars = $('ul');
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

inventory.models.forEach(function addView(model) {
  const view = Object.create(CarView).init(model);
  $cars.append(view.$el);
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

$cars.on('click', 'a', function removeModel(e) {
  e.preventDefault();
  const $link = $(e.target);
  const model = inventory.get(parseInt($link.attr('data-id'), 10));

  model.view.remove();
  inventory.remove(model);
});

render();
