$( document ).ready( function() {

  $('.delete-person').bind('ajax:complete', function() {
    $(this).closest('.person-container').remove();
  });

});
