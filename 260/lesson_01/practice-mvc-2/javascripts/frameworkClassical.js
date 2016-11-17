function ModelConstructor(opts) {
  let idCount = 0;

  class Model {
    constructor(attrs) {
      idCount++;
      this.id = idCount;
      this.attributes = attrs || {};
      this.attributes.id = idCount;
    }

    set(key, val) {
      this.attributes[key] = val;
    }

    get(key) {
      return this.attributes[key];
    }
  }

  Object.setPrototypeOf(Model.prototype, opts || {});
  return Model;
}
