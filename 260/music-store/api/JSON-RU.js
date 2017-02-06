const fs = require('fs');

module.exports = {
  JSONFilePath: '',
  tempStore: {},
  read() {
    this.tempStore = JSON.parse(fs.readFileSync(this.JSONFilePath, 'utf8'));
    return this.tempStore;
  },

  put(input) {
    const newData = Object.assign({}, input);
    this.tempStore.lastId += 1
    newData.id = this.tempStore.lastId;
    this.tempStore.data.push(newData);

    return this.tempStore;
  },

  record() {
    fs.writeFileSync(this.JSONFilePath, JSON.stringify(this.tempStore), 'utf8');
  },

  init(filePath) {
    this.JSONFilePath = filePath;
    this.read();
    return this;
  },
};
