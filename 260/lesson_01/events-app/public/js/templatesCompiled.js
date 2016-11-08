(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['editEvent'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<form id=\"edit-event\" name=\"edit-event\" method=\"post\" action=\"events/edit/"
    + alias4(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"id","hash":{},"data":data}) : helper)))
    + "\">\n  <fieldset>\n    <input type=\"hidden\" value=\""
    + alias4(((helper = (helper = helpers["event-id"] || (depth0 != null ? depth0["event-id"] : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"event-id","hash":{},"data":data}) : helper)))
    + "\">\n    <dl>\n      <dt><label for=\"name\">Name</label></dt>\n      <dd><input type=\"text\" id=\"name\" name=\"name\" value=\""
    + alias4(((helper = (helper = helpers.name || (depth0 != null ? depth0.name : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"name","hash":{},"data":data}) : helper)))
    + "\"></dd>\n      <dt><label for=\"date\">Date</label></dt>\n      <dd><input type=\"date\" id=\"date\" name=\"date\" value=\""
    + alias4(((helper = (helper = helpers.formattedDate || (depth0 != null ? depth0.formattedDate : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"formattedDate","hash":{},"data":data}) : helper)))
    + "\"></dd>\n      <dt><label for=\"name\">Notes</label></dt>\n      <dd><textarea id=\"notes\" name=\"notes\" rows=\"10\" cols=\"50\">"
    + alias4(((helper = (helper = helpers.notes || (depth0 != null ? depth0.notes : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"notes","hash":{},"data":data}) : helper)))
    + "</textarea></dd>\n    </dl>\n  </fieldset>\n  <input type=\"submit\" value=\"save\" name=\"save\" class=\"btn btn-add\">\n  <button type=\"button\" name=\"cancel\" class=\"btn btn-cancel\">Cancel</button>\n</form>\n";
},"useData":true});
templates['event'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<article class=\"event\" data-event-id="
    + alias4(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"id","hash":{},"data":data}) : helper)))
    + ">\n  <header>\n    <h2>"
    + alias4(((helper = (helper = helpers.name || (depth0 != null ? depth0.name : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"name","hash":{},"data":data}) : helper)))
    + " - "
    + alias4(((helper = (helper = helpers.formattedDate || (depth0 != null ? depth0.formattedDate : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"formattedDate","hash":{},"data":data}) : helper)))
    + "</h2>\n  </header>\n  <section>\n    <h2>Notes</h2>\n    <p>"
    + alias4(((helper = (helper = helpers.notes || (depth0 != null ? depth0.notes : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"notes","hash":{},"data":data}) : helper)))
    + "</p>\n    <a href=\"/event/edit/"
    + alias4(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"id","hash":{},"data":data}) : helper)))
    + "\">Edit Event</a>\n  </div>\n</article>";
},"useData":true});
templates['events'] = template({"1":function(container,depth0,helpers,partials,data) {
    var stack1;

  return ((stack1 = container.invokePartial(partials.event,depth0,{"name":"event","data":data,"indent":"  ","helpers":helpers,"partials":partials,"decorators":container.decorators})) != null ? stack1 : "");
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1;

  return ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.events : depth0),{"name":"each","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
},"usePartial":true,"useData":true});
templates['newEvent'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<form id=\"add-event\" name=\"add-event\" method=\"post\" action=\"events/add/"
    + container.escapeExpression(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"id","hash":{},"data":data}) : helper)))
    + "\">\n  <fieldset>\n    <dl>\n      <dt><label for=\"name\">Name</label></dt>\n      <dd><input type=\"text\" id=\"name\" name=\"name\" placeholder=\"Event Name\"></dd>\n      <dt><label for=\"date\">Date</label></dt>\n      <dd><input type=\"date\" id=\"date\" name=\"date\" placeholder=\"Event Date\"></dd>\n      <dt><label for=\"name\">Notes</label></dt>\n      <dd><textarea id=\"notes\" name=\"notes\" rows=\"10\" cols=\"50\"></textarea></dd>\n    </dl>\n  </fieldset>\n  <input type=\"submit\" value=\"Add\" name=\"submit\" class=\"btn btn-add\">\n  <button type=\"button\" name=\"cancel\" class=\"btn btn-cancel\">Cancel</button>\n</form>";
},"useData":true});
})();