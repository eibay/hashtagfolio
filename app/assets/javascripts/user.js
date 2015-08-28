$(document).ready(function() {
  var syncImages = function() {
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
          $flashSuccess.fadeOut({
            duration: 1000,
            complete: function() {
              $flashSuccess.remove();
            }
          });
        }, 3000);
      },
      error: function() {
        $flashNotice.fadeOut({
          duration: 1000,
          complete: function() {
            $flashNotice.remove();
          }
        });
        $('.container').prepend($flashError);
        $flashError.fadeIn();
        window.setTimeout(function() {
          $flashError.fadeOut({
            duration: 1000,
            complete: function() {
              $flashError.remove();
            }
          });
        }, 3000);
      },
      complete: function() {
        app.syncing = false;
      }
    });
    app.syncing = true;
    $('.container').prepend($flashNotice);
    $flashNotice.fadeIn();
  };

  if (app.sync_images && !app.syncing) {
    syncImages();
  }

  $flashMessages = $('.flash');
  window.setTimeout(function() {
    $flashMessages.fadeOut({
      duration: 1000,
      complete: function() {
        $flashMessages.remove();
      }
    });
  }, 3000);

  $updateMediaLink = $('#update-media-link');
  $updateMediaLink.on('click', function() {
    event.preventDefault();
    event.stopPropagation();
    if (!app.syncing) {
      syncImages();
    }
  });

});
