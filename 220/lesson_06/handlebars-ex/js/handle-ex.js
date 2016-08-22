$(function() {
  var postTemplate = Handlebars.compile($("#blogTemplate").html());
  var blogTags = Handlebars.compile($("#blogTags").html());
  Handlebars.registerPartial("blogTags", $("#blogTags").html());

  var post = {
    title: "First blog entry",
    publishedDate: (new Date()).toUTCString(),
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    tags: ['pig', 'dog', 'cat'],
  };


  $("body").append(postTemplate(post));
});
