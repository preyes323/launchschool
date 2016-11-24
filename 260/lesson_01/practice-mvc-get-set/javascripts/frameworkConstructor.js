function ModelConstructor(opts) {
  let idCount = 0;

  function Model(attrs) {
    idCount++;
    this.id = idCount;
    this.attributes = attrs || {};
    this.attributes.id = idCount;
    if (opts && opts.change && typeof opts.change === 'function') {
      this.__events.push(opts.change);
    }
  }

  Model.prototype = {
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
      this.__events.forEach((event) => event());
    },
  };

  Object.assign(Model.prototype, opts);
  return Model;
}

function CollectionConstructor(opts) {
  function Collection(model) {
    this.model = model;
    this.models = [];
  }

  Collection.prototype = {
    reset() {
      this.models = [];
    },
    add(model) {
      const found = this.models.filter((existingModel) => existingModel.id === model.id)
      if (found.length) return found[0];
      const newModel = new this.model(model);
      this.models.push(newModel);
      return newModel;
    },
    remove(model) {
      const id = typeof model === 'object' ? model.id : model;
      if (this.models.every((existingModel) => existingModel.id !== id)) return;
      this.models = this.models.filter((existingModel) => existingModel.id !== id);
    },
    get(model) {
      const id = typeof model === 'object' ? model.id : model;
      return this.models.filter((existingModel) => existingModel.id === id)[0];
    },
    set(models) {
      const newModels = Array.isArray(models) ? models.slice() : [models];
      this.reset();
      newModels.forEach(this.add.bind(this));
    },
  };

  Object.assign(Collection.prototype, opts);
  return Collection;
}
