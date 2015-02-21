
$(document).ready(function(){
	$('#showOther').click(function(e){
		e.preventDefault();
		console.log("click show-other-fields")
		$('.show-hidden').toggleClass('hidden-xs');
	})
})