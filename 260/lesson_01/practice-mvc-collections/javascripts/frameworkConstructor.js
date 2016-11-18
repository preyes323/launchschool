function ModelConstructor(opts) {
  let idCount = 0;

  function Model(attrs) {
    idCount++;
    this.id = idCount;
    this.attributes = attrs || {};
    this.attributes.id = idCount;
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
    add(event) {
      this.__events.push(event);
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
  if (opts.change && typeof opts.change === 'function') {
    Model.prototype.__events.push(opts.change);
  }

  return Model;
}
