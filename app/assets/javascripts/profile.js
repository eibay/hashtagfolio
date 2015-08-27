$(document).ready(function () {
  var source = $('#album-template').html();
  var albumTemplate = Handlebars.compile(source);

  var $albums = $('#albums');

  $.getJSON('/users/' + $albums.data('user-id'), function(response) {
    JSON.parse(response.albums).forEach(function(album) {
      var $album = $(albumTemplate(album));
      $albums.append($album);
    });

    $('.hero').css('background-image', 'url(' + response.user_cover_url + ')');

  });


});
