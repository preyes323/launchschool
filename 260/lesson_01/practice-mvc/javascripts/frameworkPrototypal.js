function ModelConstructor(opts) {
  let idCount = 0;

  const Model = {
    set(key, val) {
      this.attributes[key] = val;
    },
    get(key) {
      return this.attributes[key];
    },
    init(attrs) {
      idCount++;
      this.id = idCount;
      this.attributes = attrs || {};
      this.attributes.id = idCount;
      return this;
    },
  };

  Object.assign(Model, opts || {});
  return Object.create(Model);
}
