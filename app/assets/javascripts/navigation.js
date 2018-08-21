$( document ).ready( function() {

	//Primary Navigation Dropdown
	$('.js-dropdown-toggle').on ('click', function(e){
		e.preventDefault();
		$('.nav-item__dropdown').toggleClass('open');
	});

	/* $('html').on('click', function(e){
		if ( $('.nav-item__dropdown').hasClass('open') ) {
			$('.nav-item__dropdown').removeClass('open');
		}
	}); */

	/* Responsive nav Toggle */
	$( ".navbar-toggle" ).click(function(e) {
	    e.preventDefault();
	    $('.js-nav-collapse').toggleClass('open');
	    $('#inner-wrap').toggleClass('open');
	});


	/* $('html').mousedown(function (){
		if ( $('#inner-wrap').hasClass('open') ) {
			$('#inner-wrap').on('click', function(){
				$('#inner-wrap').removeAttr('class');
		    	$('.js-nav-collapse').removeClass('open');
			});
		}
	});*/
});


