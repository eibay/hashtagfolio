$(document).ready(function() {
  var source = $('#album-template').html();
  var albumTemplate = Handlebars.compile(source);

  var $albums = $('#albums');
  var userID = $albums.data('user-id');
  var ajaxURL;
  if (userID) {
    ajaxURL = "/users/" + userID + "/albums";
  } else {
    ajaxURL = "/albums/";
  }
  $.getJSON(ajaxURL, function(response) {
    response.forEach(function(album) {
      var $album = $(albumTemplate(album));
      $albums.append($album);
    });

  });
});
