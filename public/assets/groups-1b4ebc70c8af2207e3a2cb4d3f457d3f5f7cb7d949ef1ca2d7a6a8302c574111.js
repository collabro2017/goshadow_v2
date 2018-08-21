$( document ).ready( function() {

  $('.delete-group').bind('ajax:complete', function() {
    $(this).closest('.group-list-item').remove();
  });

  $('.launch-add-to-group-modal').click(function() {
    $('.reference-id').each(function () {
      if ( this.checked ) {
        $('.group_id').append("<input type='text' name='reference_ids[]' value='" + this.value + "'/>");
      }
    });
  });

  $('#addToGroup').bind('ajax:complete', function(xhr, data, response) {
    $('.message-container').html(data.responseText);
  });

});
