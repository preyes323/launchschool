const express = require('express');
const path = require('path');
const logger = require('morgan');

const app = express();
const events = require("./routes/events");

app.use(logger('dev'));
app.use(express.static(path.join(__dirname, 'public')));
app.use("/events", events);

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
