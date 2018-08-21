$( document ).ready( function() {

	// Use this to test with a pre-selected  value on load
	//$('#plan_id').find('option[value=3]').attr('selected','selected');

	// Use button to highlight pricing grid and add select value
	$('.pricing-solo').click(function() {
		$('.pricing-column').removeClass('pricing-active');
		$(this).closest('.pricing-column').addClass('pricing-active');
		$('#plan_id').val('1');
		$('body').scrollTo($('#billing-info'), 400, {offset:-30});
	});
	$('.pricing-team').click(function(e) {
		$('.pricing-column').removeClass('pricing-active');
		$(this).closest('.pricing-column').addClass('pricing-active');
		$('#plan_id').val('2');
		$('body').scrollTo($('#billing-info'), 400, {offset:-30});
	});
	$('.pricing-facility').click(function(e) {
		$('.pricing-column').removeClass('pricing-active');
		$(this).closest('.pricing-column').addClass('pricing-active');
		$('#plan_id').val('3');
		$('body').scrollTo($('#billing-info'), 400, {offset:-30});
	});

	// Display a highlighted pricing column on load
	var plan = $('#plan_id option:selected').val();

	if ( (plan == "1") ){
		$('#pricing-solo').closest('.pricing-column').addClass('pricing-active');
	} else if ( (plan == "2") ){
		$('#pricing-team').closest('.pricing-column').addClass('pricing-active');
	} else if ( (plan == "3") ){
		$('#pricing-facility').closest('.pricing-column').addClass('pricing-active');
	} 

	// Display Countries
	$('#plan_id').change(function(e) {
		e.preventDefault();
		var plan = $('#plan_id option:selected').val();
		if ( (plan == "1") ){
			$('.pricing-column').removeClass('pricing-active');
			$('.pricing-solo').closest('.pricing-column').addClass('pricing-active');
		} else if ( (plan == "2") ){
			$('.pricing-column').removeClass('pricing-active');
			$('.pricing-team').closest('.pricing-column').addClass('pricing-active');
		} else if ( (plan == "3") ){
			$('.pricing-column').removeClass('pricing-active');
			$('.pricing-facility').closest('.pricing-column').addClass('pricing-active');
		} 
	});

	$('#transferCoordinator').on('ajax:success', function( xhr, data, response ) {
    window.location.replace('/organizations/' + data.id + '/experiences');
  }).on('ajax:error', function(xhr, data, response) {
		var messageContainer = $('.form-message-container')
		$(messageContainer).removeClass('hide');
		$(messageContainer).html("Shadower is not valid.");
  });

});