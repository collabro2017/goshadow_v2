$( document ).ready( function() {

  $('.delete-place').bind('ajax:complete', function() {
    $(this).closest('.place-container').remove();
  });

});