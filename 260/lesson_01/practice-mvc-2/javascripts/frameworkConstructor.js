function ModelConstructor(opts) {
  let idCount = 0;

  function Model(attrs) {
    idCount++;
    this.id = idCount;
    this.attributes = attrs || {};
    this.attributes.id = idCount;
    this.__events = [];
  }

  Model.prototype = {
    set(key, val) {
      this.attributes[key] = val;
    },
    get(key) {
      return this.attributes[key];
    },
    triggerChange() {
      this.__events.forEach((event) => event());
    },
  };

  Object.assign(Model.prototype, opts);

  return Model;
}
