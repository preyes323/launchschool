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
    + alias4((helpers.formatDate || (depth0 && depth0.formatDate) || alias2).call(alias1,(depth0 != null ? depth0.price : depth0),{"name":"formatDate","hash":{},"data":data}))
    + "</p>\n<a href='#' class='btn btn-add'>Add to Cart</a>";
},"useData":true});
templates['index'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<header>\n  <h1>"
    + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
    + "</h1>\n  <a class=\"btn btn-new\" href=\"/albums/new\">New Album</a>\n</header>\n<ul></ul>\n";
},"useData":true});
templates['newAlbum'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<form class='add-album' method='post' action='/new-album'>\n  <h1>Add Album</h1>\n  <fieldset>\n    <dl>\n      <dt><label for='title'>Title</label></dt>\n      <dd><input type='text' id='title' name='title' required></dd>\n      <dt><label for='artist'>Artist</label></dt>\n      <dd><input type='text' id='artist' name='artist' required></dd>\n      <dt><label for='date'>Release Date</label></dt>\n      <dd><input type='date' id='date' name='date' required></dd>\n      <dt><label for='cover'>Cover URL</label></dt>\n      <dd><input type='url' id='cover' name='cover'></dd>\n      <dt><label for='price'>Price</label></dt>\n      <dd><input type='text' id='price' name='price' required></\n    </dl>\n  </fieldset>\n  <fieldset>\n    <input type='submit' value='Add' class='btn btn-add'>\n  </fieldset>\n</form>";
},"useData":true});
})();