$( document ).ready( function() {

  $('.remove-ref-from-group').bind('ajax:complete', function() {
    $(this).closest('.group-list-item__reference').remove();
  });

});