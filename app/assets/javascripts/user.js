$(document).ready(function() {
  if (app.sync_images) {
    var $flashNotice = $('<div>').addClass('flash-notice').html("Your Instagram images are loading...").hide();
    var $flashSuccess = $('<div>').addClass('flash-notice').html("Your images have been loaded.").hide();
    var $flashError = $('<div>').addClass('flash-error').html("Something went wrong.").hide();
    $.ajax({
      url: "/users/" + app.current_user_id + "/update_media.json",
      method: "POST",
      success: function(response) {
        $flashNotice.fadeOut();
        $flashNotice.remove();
        $('.container').prepend($flashSuccess);
        $flashSuccess.fadeIn();
        window.setTimeout(function() {
          $flashSuccess.fadeOut();
          $flashSuccess.remove();
        }, 3000);
      },
      error: function() {
        $flashNotice.fadeOut();
        $flashNotice.remove();
        $('.container').prepend($flashError);
        $flashError.fadeIn();
      }
    });
    $('.container').prepend($flashNotice);
    $flashNotice.fadeIn();
  }

});
