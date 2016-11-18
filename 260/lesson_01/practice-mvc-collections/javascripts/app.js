var template = Handlebars.compile($("#cars").html());

var Car = new ModelConstructor(),
    Cars = new CollectionConstructor(),
    inventory = new Cars(Car);

inventory.add({
  make: "BMW",
  model: "328i"
});
inventory.add({
  make: "Mini",
  model: "Cooper"
});
inventory.add({
  make: "Lotus",
  model: "Elise"
});

$("a").on("click", function(e) {
  e.preventDefault();

  inventory.reset();
  render();
});

$("form").on("submit", function(e) {
  e.preventDefault();
  var $form = $(this),
      properties = {
        make: $form.find("[name=make]").val(),
        model: $form.find("[name=model]").val()
      };

  inventory.add(properties);
  render();
  this.reset();
});

render();

function render() {
  $("article").html(template({ cars: inventory.models }));
}
