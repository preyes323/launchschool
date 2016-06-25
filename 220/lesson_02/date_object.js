function formattedDate(date) {
  var day = formattedDay(date),
      month = formattedMonth(date);

  console.log("Today's date is " + day + ", " + month + " " + dateSuffix(date) + " " +date.getFullYear());
}

function formattedDay(date) {
  var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  return days[date.getDay()];
}

function formattedMonth(date) {
  var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  return months[date.getMonth()];
}

function dateSuffix(date) {
  date = date.getDay();

  switch(date)
  {
    case 1: return date + "st";
    case 2: return date + "nd";
    case 3: return date + "rd";
    default: return date + "th";
  }
}

function formatTime(date) {
  var hours = date.getHours().toString();
  var minutes = date.getMinutes().toString();

  if (hours.length < 2) { hours = "0" + hours; }
  if (minutes.length < 2) { minutes = "0" + minutes; }

  return hours + ":" + minutes;
}

var today = new Date();

formattedDate(today);
console.log(today.getTime());

var tomorrow = new Date(today);
tomorrow.setDate(today.getDate() + 1);

formattedDate(tomorrow);

var next_week = new Date(today);
console.log(today == next_week);
console.log(today.toDateString() == next_week.toDateString());

next_week.setDate(today.getDate() + 7);
console.log(today.toDateString() == next_week.toDateString());

console.log(formatTime(today));
