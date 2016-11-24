function ModelConstructor(opts) {
  let idCount = 0;

  class Model {
    constructor(attrs) {
      idCount++;
      this.id = idCount;
      this.attributes = attrs || {};
      this.attributes.id = idCount;
      if (opts && opts.change && typeof opts.change === 'function') {
        this.__events.push(opts.change);
      }
    }

    set(key, val) {
      this.attributes[key] = val;
      this.triggerChange();
    }

    get(key) {
      return this.attributes[key];
    }

    triggerChange() {
      this.__events.forEach((cb) => cb());
    }

    add(cb) {
      this.__events.push(cb);
    }

    remove(key) {
      delete this.attributes[key];
      this.triggerChange();
    }
  }

  const ModelProto = {
    __events: [],
  };

  Object.assign(ModelProto, opts);
  Object.setPrototypeOf(Model.prototype, ModelProto);
  return Model;
}

function CollectionConstructor(opts) {
  class Collection {
    constructor(modelConstructor) {
      this.Model = modelConstructor;
      this.models = [];
    }

    reset() {
      this.models = [];
    }

    add(model) {
      const foundModel = this.models.filter((existingModel) => existingModel.id === model.id);
      if (foundModel.length) return foundModel[0];
      const newModel = new this.Model(model);
      this.models.push(newModel);
      return newModel;
    }

    remove(model) {
      const modelId = typeof model === 'number' ? model : model.id;
      if (this.models.every((existingModel) => existingModel.id !== modelId)) return;
      this.models = this.models.filter((existingModel) => existingModel.id !== modelId);
    }
  }

  Object.setPrototypeOf(Collection.prototype, opts || {});
  return Collection;
}
