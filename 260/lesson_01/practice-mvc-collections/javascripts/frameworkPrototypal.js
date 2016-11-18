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
      if (opts.change && typeof opts.change === 'function') {
        this.__events.push(opts.change);
      }
      return this;
    },
  };

  Object.assign(Model, opts || {});
  return Object.create(Model);
}
