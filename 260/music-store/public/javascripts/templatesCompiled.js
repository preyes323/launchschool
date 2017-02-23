(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['album'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<img src="
    + alias4(((helper = (helper = helpers.cover || (depth0 != null ? depth0.cover : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"cover","hash":{},"data":data}) : helper)))
    + ">\n<h2>"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + "</h2>\n<h3>"
    + alias4(((helper = (helper = helpers.artist || (depth0 != null ? depth0.artist : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"artist","hash":{},"data":data}) : helper)))
    + "</h3>\n<p>Released: "
    + alias4(((helper = (helper = helpers.date || (depth0 != null ? depth0.date : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"date","hash":{},"data":data}) : helper)))
    + "</p>\n<p>$"
    + alias4((helpers.formatPrice || (depth0 && depth0.formatPrice) || alias2).call(alias1,(depth0 != null ? depth0.price : depth0),{"name":"formatPrice","hash":{},"data":data}))
    + "</p>\n<a href='#' class='btn btn-add'>Add to Cart</a>";
},"useData":true});
templates['cart'] = template({"1":function(container,depth0,helpers,partials,data) {
    return "      $"
    + container.escapeExpression((helpers.formatPrice || (depth0 && depth0.formatPrice) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.cartTotal : depth0),{"name":"formatPrice","hash":{},"data":data}))
    + "\n";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1, alias1=depth0 != null ? depth0 : {};

  return "<label for=\"cart-toggle\">\n  "
    + container.escapeExpression((helpers.pluralize || (depth0 && depth0.pluralize) || helpers.helperMissing).call(alias1,(depth0 != null ? depth0.cartQuantity : depth0),{"name":"pluralize","hash":{},"data":data}))
    + "\n</label>\n<input id=\"cart-toggle\" type=\"checkbox\">\n<div class=\"items\">\n  <ul></ul>\n  <p>\n"
    + ((stack1 = helpers["if"].call(alias1,(depth0 != null ? depth0.cartTotal : depth0),{"name":"if","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
    + "  </p>\n</div>\n";
},"useData":true});
templates['cartItem'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<a href=\"#\">Remove</a>\n"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + " x "
    + alias4(((helper = (helper = helpers.quantity || (depth0 != null ? depth0.quantity : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"quantity","hash":{},"data":data}) : helper)))
    + "\n<small>$"
    + alias4((helpers.formatPrice || (depth0 && depth0.formatPrice) || alias2).call(alias1,(depth0 != null ? depth0.price : depth0),{"name":"formatPrice","hash":{},"data":data}))
    + "</small>\n\n";
},"useData":true});
templates['index'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<header>\n  <h1>"
    + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
    + "</h1>\n  <a class=\"btn btn-new\" href=\"/albums/new\">New Album</a>\n</header>\n<ul class=\"albums\"></ul>\n";
},"useData":true});
templates['newAlbum'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<form class='add-album' method='post' action='/new-album'>\n  <h1>Add Album</h1>\n  <fieldset>\n    <dl>\n      <dt><label for='title'>Title</label></dt>\n      <dd><input type='text' id='title' name='title' required></dd>\n      <dt><label for='artist'>Artist</label></dt>\n      <dd><input type='text' id='artist' name='artist' required></dd>\n      <dt><label for='date'>Release Date</label></dt>\n      <dd><input type='date' id='date' name='date' required></dd>\n      <dt><label for='cover'>Cover URL</label></dt>\n      <dd><input type='url' id='cover' name='cover'></dd>\n      <dt><label for='price'>Price</label></dt>\n      <dd><input type='text' id='price' name='price' required></\n    </dl>\n  </fieldset>\n  <fieldset>\n    <input type='submit' value='Add' class='btn btn-add'>\n  </fieldset>\n</form>";
},"useData":true});
})();