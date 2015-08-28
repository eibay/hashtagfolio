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
      album.cover_url = album.cover_url || "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/e35/11363659_995868700464866_380212249_n.jpg";
      var $album = $(albumTemplate(album));
      $albums.append($album);
    });

  });
});
