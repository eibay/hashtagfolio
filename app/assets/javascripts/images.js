$(document).ready(function() {
  var source = $('#image-template').html();
  var imageTemplate = Handlebars.compile(source);

  var $images = $('#images');

  $.getJSON('/albums/' + $images.data('album-id'), function(response) {
    response.forEach(function(image) {
      var $image = $(imageTemplate(image));
      $images.append($image);
    });
  });

  $images.on('click', '.image', function() {
    var url = $(this).find('img').attr('src');
    $('#lightbox-image').attr('src', url);
    $("body").addClass("modal-open");
    $(".modal-fade-screen").addClass("open");
  });

  $(".modal-fade-screen").on("click", function() {
    $("body").removeClass("modal-open");
    $(".modal-fade-screen").removeClass("open");
  });

  $(".modal-inner").on("click", function(e) {
    e.stopPropagation();
  });


});
