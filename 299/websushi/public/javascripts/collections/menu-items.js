const MenuItems = Backbone.Collection.extend({
  url: '/menu-items/menu.json',
  model: MenuItem,
});
