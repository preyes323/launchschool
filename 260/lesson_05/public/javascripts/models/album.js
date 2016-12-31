const Album = Backbone.Model.extend({
  parse(response) {
    const model = _.extend({}, response);
    model.tracksUrl = `/albums/${model.title}.json`;
    return model;
  },
});
