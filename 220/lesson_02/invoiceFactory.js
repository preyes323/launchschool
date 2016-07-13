function createInvoice(services) {
  services = services || {};
  var invoice = {};
  invoice.phone = services.phone || 3000;
  invoice.internet = services.internet || 5500;
  invoice.payments = [];
  invoice.totalPayments = paymentTotal;
  invoice.total = function() {
    return this.phone + this.internet;
  };
  invoice.addPayment = function(payment) {
    this.payments.push(payment);
  };
  invoice.addPayments = function(payments) {
    this.payments = this.payments.concat(payments);
  };
  invoice.amountDue = function() {
    return this.total() - this.totalPayments(this.payments);
  };

  return invoice;
}

function invoiceTotal(invoices) {
  var total = 0;
  for (var i = 0, length = invoices.length; i < length; i++) {
    total += invoices[i].total();
  }
  return total;
}

function createPayment(services) {
  services = services || {};
  return {
    phone: services.phone || 0,
    internet: services.internet || 0,
    amount: services.amount || 0,
    total: function() {
      if (this.amount > 0) return this.amount;
      return this.phone + this.internet;
    }
  };
}

function paymentTotal(payments) {
  var total = 0;
  for (var i = 0, length = payments.length; i < length; i++) {
    total += payments[i].total();
  }

  return total;
}

var invoice = createInvoice({phone: 1200, internet: 4000});
var payment1 = createPayment({amount: 2000});
var payment2 = createPayment({phone: 1000, internet: 1200});
var payment3 = createPayment({phone: 1000});

invoice.addPayment(payment1);
invoice.addPayments([payment2, payment3]);
console.log(invoice.amountDue());
