var invoices = {
  unpaid: [],
  paid: [],
  add: function(name, amount) {
    this.unpaid.push( { name: name, amount: amount } );
  },
  total_due: function() {
    var total = 0

    for (var i = 0; i < this.unpaid.length; i++) {
      total += this.unpaid[i].amount;
    }

    return total;
  },
  total_paid: function() {
    var total = 0

    for (var i = 0; i < this.paid.length; i++) {
      total += this.paid[i].amount;
    }

    return total;
  },
  pay_invoice: function(name) {
    var new_unpaid = [];

    for (var i = 0; i < this.unpaid.length; i++) {
      if (this.unpaid[i].name === name) {
        this.paid.push( this.unpaid[i] );
      } else {
        new_unpaid.push ( this.unpaid[i] );
      }
    }

    this.unpaid = new_unpaid
  }
};

invoices.add("Due North Development", 250);
invoices.add("Moonbeam Interactive", 187.5);
invoices.add("Slough Digital", 300);

console.log(invoices.total_due());

invoices.pay_invoice("Due North Development");
invoices.pay_invoice("Slough Digital");

console.log(invoices.total_due());
