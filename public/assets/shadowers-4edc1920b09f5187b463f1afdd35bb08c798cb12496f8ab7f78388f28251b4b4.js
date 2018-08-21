$( document ).ready( function() {
  
  $('#new_invite').on('ajax:success', function( xhr, data, response ) {
    $('input:radio').attr('checked', false);
    $('input:text').val('');
    $('.invite-message-container').html('<div class="alert notice">Invite Sent Successfully!</div>');
  }).on('ajax:error', function(xhr, data, response) {
    var errors = JSON.parse( data.responseText ).errors;
    $('.invite-message-container').html(errors);
  });

  $('#add_shadowers_to_experience').on('ajax:success', function( xhr, data, response ) {
    $('.add-shadower-message-container').html('<div class="alert notice">Shadowers Added Successfully!</div>');
  }).on('ajax:error', function(xhr, data, response) {
    var errors = JSON.parse( data.responseText ).errors;
    $('.add-shadower-message-container').html(errors);
  });

  $('.js-existing-shadower-invite').on('click', function() {
    
    var inviteUserRow = $(this);
    if ( inviteUserRow.hasClass('active-row') ) {
      inviteUserRow.find('.user-id-ux-field').val('');
      inviteUserRow.removeClass('active-row');
    } else {
      inviteUserRow.addClass('active-row');
      inviteUserRow.find('.user-id-ux-field').val( inviteUserRow.attr('user-id') );
    }

  });

  $('.remove-shadower').bind('ajax:complete', function() {
    $(this).closest('.shadower-row').remove();
  });

});
