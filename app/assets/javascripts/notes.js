$( document ).ready( function() {
  
  $('.note-single__delete').bind('ajax:complete', function() {
    $(this).closest('.note-container').remove();
  });

  $( '.note-single__accolade' ).click(function() {
    
    event.preventDefault();
    var upThumb = $(this);
    var noteId = upThumb.attr('note-id');
    var downThumb = $('#noteDown' + noteId);

    if ( upThumb.hasClass('active-thumb') ) {
      
      upThumb.removeClass('active-thumb');
      updateNoteStatus(noteId, null);
      //alert( "Removed Positive" );
    
    } else {

      upThumb.addClass('active-thumb');
      downThumb.removeClass('active-thumb');
      updateNoteStatus(noteId, 'Positive');
      //alert( "Added Positive" );

    }
  
  });

  $( '.note-single__opportunity' ).click(function() {
    
    event.preventDefault();
    var downThumb = $(this);
    var noteId = downThumb.attr('note-id');
    var upThumb = $('#noteUp' + noteId);

    if ( downThumb.hasClass('active-thumb') ) {
      
      downThumb.removeClass('active-thumb');
      updateNoteStatus(noteId, null);
      //alert( "Removed Negative" );
    
    } else {

      downThumb.addClass('active-thumb');
      upThumb.removeClass('active-thumb');
      updateNoteStatus(noteId, 'Negative');
      //alert( "Added Negative" );

    }

  });

  function updateNoteStatus(noteId, status) {
    $.ajax({
      type: 'patch',
      dataType: 'JSON',
      url: '/notes/' + noteId + '/update_status',
      data: { status: status }
    });
  }

});