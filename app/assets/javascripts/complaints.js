var ready;
console.log('s')
ready = function(){
	var click;
	// $('body').on('click', '.aw', function(e){
	// 	console.log($(this).next()[0])
	// 	$($(this).next()[0]).removeClass('hidden')
	// });
}

$(document).ready(ready);
$(document).on('page:load', ready)