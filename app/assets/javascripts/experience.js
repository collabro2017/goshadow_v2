$( document ).ready( function() {
  
  $('#new_experience').on('ajax:success', function( xhr, data, response ) {
    window.location.replace('/organizations/' + data.organization_id + '/experiences');
  }).on('ajax:error', function(xhr, data, response) {
    var errors = JSON.parse( data.responseText ).errors;
    $('.error-container').html(errors);
  });

  $('.delete-experience').bind('ajax:complete', function() {
    $(this).closest('.experience-card').remove();
    alert('Experience Deleted.');
  });

});