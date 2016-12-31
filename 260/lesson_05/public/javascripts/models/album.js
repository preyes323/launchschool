const Album = Backbone.Model.extend({
  parse(response) {
    const model = _.extend({}, response);
    model.tracksUrl = `/album/${model.title}`;
    return model;
  },
});
