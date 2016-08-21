var inventory;

(function() {
  inventory = {
    lastId: 0,
    template: '',
    collection: {},
    setCurrentDate: function() {
      var date = new Date();
      $("#dateOrdered").text(date.toUTCString());
    },
    cacheTemplate: function() {
      var $temp = $("#inventoryItem");
      $temp.remove();
      this.template = $temp.text();
    },
    add: function() {
      this.collection[this.lastId += 1] = {
        itemName: '',
        itemStockNumber: '',
        itemQuantity: 1,
      };
    },
    update: function(id, data) {
      for (var item in this.collection[id]) {
        this.collection[id][item] = data[item + id];
      }
    },
    getData: function(item) {
      var objData = {};
      item.find(":input").serializeArray().forEach(function(item) {
        objData[item.name] = item.value;
      });

      return objData;
    },
    findParent: function(e, parent) {
      return $(e.currentTarget).closest(parent);
    },
    newItem: function() {
      this.add();
      var $item = $(this.template.replace(/ID/g, this.lastId));
      $item.appendTo($("#items tbody"));
    },
    deleteItem: function(e) {
      e.preventDefault();
      var $item = this.findParent(e, "tr");
      delete this.collection[$item.find("input[type='hidden']").val()];
      $item.remove();
    },
    updateItem: function(e) {
      e.preventDefault();
      var $item = this.findParent(e, "tr");
      var id = $item.find("input[type='hidden']").val();
      var data = this.getData($item);
      this.update(id, data);
    },
    bindEvents: function() {
      $("#addItem").on("click", $.proxy(this.newItem, this));
      $("#items").on("click", "a.delete", $.proxy(this.deleteItem, this));
      $("#items").on("blur", ":input", $.proxy(this.updateItem, this));
    },
    init: function() {
      this.setCurrentDate();
      this.cacheTemplate();
      this.bindEvents();
    },
  };
})();

$($.proxy(inventory.init, inventory));
