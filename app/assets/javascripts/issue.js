
$(document).ready(function(){
	$('#showOther').click(function(e){
		e.preventDefault();
		console.log("click show-other-fields")
		$('.show-hidden').toggleClass('hidden-xs');
	})

	$('body').on('change', '#l-issue-select', function(){
		var id = $(this).val();
		window.location.href = '/issues?loc=' + id
	})

})