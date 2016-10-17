var express = require('express');
var router = express.Router();
var fs = require("fs");
var path = require("path");
var _ = require("underscore");
var md5 = require("MD5");

var events = JSON.parse(fs.readFileSync(path.resolve(path.dirname(__dirname), "data/events.json"), "utf8")),
    last_id = _(events).last().id;

function getFormattedDate(month, date) {
  var today = new Date(),
      year = (today.getFullYear() + "").split("").slice(2).join("");

  return month + "/" + date + "/" + year;
}

function getTimestamp(month, date) {
  var d = new Date();
  d.setDate(date);
  d.setMonth(month - 1);
  (["Hours", "Minutes", "Seconds", "Milliseconds"]).forEach(function(h) {
    d["set" + h](0);
  });
  return +d;
}

router.get("/", function(req, res) {
  res.json(events);
});

router.post("/new", function(req, res) {
  var event = req.body;

  event.formatted_date = getFormattedDate(event.month, event.date);
  event.date = getTimestamp(event.month, event.date);
  event.id = ++last_id;
  events.push(event);

  res.json(event);
});

router.post("/delete", function(req, res) {
  var m = _(events).findWhere({ id: +req.body.id });

  events = events.filter(function(existing_m) {
    return existing_m.id !== m.id;
  });

  res.json({ removed: m.id });
});

module.exports = router;
