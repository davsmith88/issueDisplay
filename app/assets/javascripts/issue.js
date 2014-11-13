
$(document).ready(function(){
	$('#testing').click(function(e){
		e.preventDefault();
		console.log('test');
		$('#info').html("<p>new test</p>");
	});
})