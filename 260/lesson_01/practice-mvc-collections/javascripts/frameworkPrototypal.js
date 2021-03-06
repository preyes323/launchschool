function ModelConstructor(opts) {
  let idCount = 0;

  const Model = {
    __events: [],
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
    },
    triggerChange() {
      this.__events.forEach((cb) => {
        cb();
      });
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
  return Object.create(Model);
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
    init(modelConstructor) {
      this.model = modelConstructor;
      this.models = [];
      return this;
    },
  };

  Object.assign(Collection, opts || {});
  return Object.create(Collection);
}
