$(document).ready(function() {
  /* Activating Best In Place */
  $(".best_in_place").best_in_place();

  $('.best_in_place').bind("ajax:error", function ( xhr, data, response ) {
    alert('Value count not be saved - ' + JSON.parse(data.responseText) );
  });

});
