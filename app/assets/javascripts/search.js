$(document).ready(function() {
  var source = $('#image-template').html();
  var imageTemplate = Handlebars.compile(source);

  var $images = $('#images');

  $.ajax({
    url: '/users/' + $images.data('user-id') + '/search_results',
    success: function(response) {
      response.forEach(function(image) {
        var $image = $(imageTemplate(image));
        $images.append($image);
      });
    },
    data: { query: $images.data('query') }
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
