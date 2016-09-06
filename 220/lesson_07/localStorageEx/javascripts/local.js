$(function() {
  $("header nav").on("click", "li a", function(e) {
    e.preventDefault();
    var $clicked = $(e.target);
    var target = $clicked.data("target");
    updateNav($clicked, target);
    toggleNavTarget($clicked, target);
  });

  $("#settings").on("change", "input[type='radio']", function(e) {
    e.preventDefault();
    var $clicked = $(e.target);
    var color = $clicked.val();

    $clicked.prop("checked", true);
    $("body").attr("class", color);
    localStorage.setItem("activeRadio", $clicked.attr("id"));
  });

  $(window).on("unload", function(e) {
    localStorage.setItem("textAreaContent", $("#content form textarea").val());
  });

  function updateNav($clicked, target) {
    $("header nav li").removeClass("active");
    $clicked.closest("li").addClass("active");
    localStorage.setItem("activeTab", target);
  }

  function toggleNavTarget($clicked, target) {
    var target = $clicked.data("target");
    $("main article").removeClass("active");
    $("main article[data-property=" + target + "]").addClass("active");
  }

  function setNav() {
    var tabValue = localStorage.getItem("activeTab");
    if (tabValue) {
      var $active = $("a[data-target='" + tabValue  + "']");
      updateNav($active, tabValue);
      toggleNavTarget($active, tabValue);
    }
  }

  function setText() {
    var textValue = localStorage.getItem("textAreaContent");
    if (textValue) {
      $("#content form textarea").val(textValue);
    }
  }

  function setBackground() {
    var radioId = localStorage.getItem("activeRadio");
    if (radioId) {
      var $radio = $("#" + radioId);
      $radio.trigger("change");
    }
  }

  setNav();
  setText();
  setBackground();
});
