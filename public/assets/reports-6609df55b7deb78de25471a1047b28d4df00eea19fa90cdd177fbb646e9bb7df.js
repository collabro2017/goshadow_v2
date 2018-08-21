$( document ).ready( function() {

  $('#emailReport').bind('ajax:complete', function(xhr, data, response) {
    $('.message-container').html(data.responseText);
  });

  $('.delete-report').bind('ajax:complete', function() {
    $(this).closest('.report-container').remove();
  });

  $('.launch-send-report-modal').click(function() {
    var reportID = $(this).attr('report-id');
    $('.send-report-report-id-hidden').val(reportID);
  });

});
