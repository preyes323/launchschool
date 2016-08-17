$(function() {
  var $blinds = $("[id^='blind']");
  var delay = 1500;
  var speed = 250;

  showBlinds();

  $("a").click(function(e) {
    e.preventDefault();
    $blinds.finish();
    $blinds.removeAttr("style");
    showBlinds();
  });

  function showBlinds() {
    $blinds.each(function(idx) {
      var $blind = $blinds.eq(idx);
      $blind.delay(delay * idx + 250).animate({
        top: "+=" + $blind.height(),
        height: 0,
      }, speed);
    });
  }
});
