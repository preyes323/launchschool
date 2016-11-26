function ModelConstructor(opts) {
  let idCount = 0;

  const Model = {
    __events: [],
    __remove() {},
    set(key, val) {
      this.attributes[key] = val;
      this.triggerChange();
    },
    get(key) {
      return this.attributes[key];
    },
    addCallback(cb) {
      this.__events.push(cb);
    },
    remove(key) {
      delete this.attributes[key];
      this.triggerChange();
      this.__remove();
    },
    triggerChange() {
      this.__events.forEach((cb) => cb());
    },
    init(attrs) {
      idCount++;
      this.id = idCount;
      this.attributes = attrs || {};
      this.attributes.id = idCount;
      if (opts && opts.change && typeof opts.change === 'function') {
        this.__events.push(opts.change);
      }
      return this;
    },
  };

  Object.assign(Model, opts || {});
  return Model;
}

function CollectionConstructor(opts) {
  const Collection = {
    reset() {
      this.models = [];
    },
    add(model) {
      const foundModel = this.models.forEach((oldModel) => oldModel.id === model.id);
      if (foundModel) return foundModel[0];
      const newModel = Object.create(this.model).init(model);
      this.models.push(newModel);
      return newModel;
    },
    remove(model) {
      const modelId = typeof model === 'number' ? model : model.id;
      if (this.models.every((oldModel) => oldModel.id !== modelId)) return;
      this.models = this.models.filter((oldModel) => oldModel.id !== modelId);
    },
    set(models) {
      this.reset();
      models.forEach(this.add.bind(this));
    },
    get(modelId) {
      return this.models.filter((model) => model.id === modelId)[0];
    },
    init(modelConstructor) {
      this.model = modelConstructor;
      this.models = [];
      return this;
    },
  };

  Object.assign(Collection, opts || {});
  return Collection;
}

function ViewConstructor(opts) {
  const View = {
    tagName: 'div',
    attributes: {},
    $el: $(`<${this.tagName}/>`, this.attributes),
    template() {},
    events: {},
    getDetails(event) {
      const contents = event.split(' ');
      return {
        event: contents[0],
        selector: `${contents[1]} ${contents[2]}`,
      };
    },
    bindEvents() {
      Object.keys(this.events).forEach(function bindEvent(event) {
        const eventDetail = this.getDetails(event);
        if (!eventDetail.selector.includes('undefined')) {
          this.$el.on(`${eventDetail.event}.view`, eventDetail.selector, this.events[event].bind(this));
        } else {
          this.$el.on(`${eventDetail.event}.view`, this.events[event].bind(this));
        }
      }.bind(this));
    },
    unbindEvents() {
      this.$el.off('.view');
    },
    render() {
      this.unbindEvents();
      this.$el.html(this.template(this.model.attributes));
      this.bindEvents();
      return this.$el;
    },
    remove() {
      this.unbindEvents();
      this.$el.remove();
    },
    init(model) {
      this.model = model;
      this.model.view = this;
      this.model.addCallback(this.render.bind(this));
      this.$el = $(`<${this.tagName}/>`, this.attributes);
      this.$el.attr('data-id', this.model.id);
      this.model.__remove = this.remove.bind(this);
      this.render();
      return this;
    },
  };

  Object.assign(View, opts);
  return View;
}
