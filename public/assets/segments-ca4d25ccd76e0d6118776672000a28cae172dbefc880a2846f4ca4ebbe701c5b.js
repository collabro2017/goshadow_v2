$( document ).ready( function() {
  
  $('#new_segment').on('ajax:success', function( xhr, data, response ) {
    window.location.reload(window.location.pathname + "?tab=segments");
  }).on('ajax:error', function(xhr, data, response) {
    var errors = JSON.parse( data.responseText ).errors;
    $('.form-message-container').html(errors);
  });

  $('.remove-reference-from-segment').bind('ajax:complete', function() {
    $(this).closest('.reference-row').remove();
  });

  $('.delete-segment').bind('ajax:complete', function() {
    $(this).closest('.segment-single').remove();
  });

	/* Toggle between public and account tags */
  $('.js-tag-control').on('click', function(e) {
    e.preventDefault();
    // Toggle Classes on Tabs
    if (!$(this).hasClass('js-active')) {
      $('.js-tag-control').siblings('.js-active').removeClass('js-active');
      $(this).addClass('js-active');
    }
    // Toggle Tab Content
    if ($('#js-bulk-add-references').is(':visible')){
      $('#js-bulk-add-references').hide();
      $('#js-bulk-reference-group-section').css('display', 'block');
    } else {
      $('#js-bulk-add-references').show();
      $('#js-bulk-reference-group-section').hide();
    }
  });

  $('.segment-container').sortable({
      handle: '.segment-single__draggable'
    }).bind('sortupdate', function() {
      
      var updatedOrder = [];

      $('.segment-single__draggable').each(function(i){
        updatedOrder.push({ id: $(this).attr("data-id"), order: i + 1 });
      });

      $.ajax({
        type: 'PATCH',
        url: '/update_segment_order',
        data: { segment_order: updatedOrder }
      });

    });

});
