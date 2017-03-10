const fs = require('fs');
const _ = require('underscore');

module.exports = {
  JSONFilePath: '',
  tempStore: {},
  read() {
    this.tempStore = JSON.parse(fs.readFileSync(this.JSONFilePath, 'utf8'));
    return this.tempStore;
  },

  getLastId() {
    return this.tempStore.lastId;
  },

  get(id) {
    return  _(this.tempStore.data).findWhere({ id });
  },

  put(data) {
    const foundData = this.get(data.id);
    if (!foundData) return false;
    Object.assign(foundData, data);
    return true;
  },

  set(input) {
    const newData = Object.assign({}, input);
    this.tempStore.lastId += 1;
    newData.id = this.tempStore.lastId;
    this.tempStore.data.push(newData);

    return this.tempStore;
  },

  delete(id) {
    const idx = _(this.tempStore.data).findIndex({ id });
    return _.first(this.tempStore.data.splice(idx, 1));
  },

  record() {
    fs.writeFileSync(this.JSONFilePath, JSON.stringify(this.tempStore), 'utf8');
  },

  isUnique(field, value) {
    const result = _.find(this.tempStore.data, function(user) {
      return user[field] === value;
    });

    return !result;
  },

  findOne(field, value) {
    const result = _.find(this.tempStore.data, function(user) {
      return user[field] === value;
    });

    return result ? Object.assign({}, result) : undefined;
  },

  init(filePath) {
    this.JSONFilePath = filePath;
    this.read();
    return this;
  },
};
