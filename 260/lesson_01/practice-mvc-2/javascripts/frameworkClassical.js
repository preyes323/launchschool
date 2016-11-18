function ModelConstructor(opts) {
  let idCount = 0;

  class Model {
    constructor(attrs) {
      idCount++;
      this.id = idCount;
      this.attributes = attrs || {};
      this.attributes.id = idCount;
      if (opts.change && typeof opts.change === 'function') {
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
