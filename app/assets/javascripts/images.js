// $(document).on('page:load', ready)
var ready;
ready = function(){
	// js code to go here
	console.log("image javascript");
	var totalNumPicts = 3;
	var numPict = 5;
	var pages = (Math.ceil(totalNumPicts / numPict) - 1)
	var count = 0;
	var clickCount = 0;

	var stepId = 0;
	var code;

	$('body').on('change', '#lselect', function(){
		var id = $(this).val();
		window.location.href = '/images?loc=' + id
	})

	$('body').on('click', '.add-image' , function(e){
		stepId = $(e.target).data('step-id');
		console.log(stepId)
	});
	
	$('body').on('click', '#next', function(){
		if(clickCount < pages){
			clickCount = clickCount + 1;
			count = count + numPict;
			$('.imgHolder').empty();
			getImages(count, numPict);
		}
	});

	$('body').on('click', '#prev', function(){
		if(clickCount > 0){
			clickCount = clickCount - 1;
			count = count - numPict;
			$('.imgHolder').empty();
			getImages(count, numPict);
		}
	})


	$('body').on('show.bs.modal', function(e){
		getImages(count, numPict);
	})

	$('body').on('change', "#location_select", function(e){
		code = $('#location_select').val();
		console.log(code)
		count = 0;
		clickCount = 0;
		getImages(count, numPict, code);
	})

	$('body').on('click', '.m', function(e){
		var imgId = $(e.target).data('img-m');

		setImageToStep(imgId);
	});

	function setImageToStep(imgId){

		// var type = $('#controller_type').val();
		var type = $('#type').text();
		
		var url = "/media.js?type_id=" + stepId + "&type=" + type ;
		console.log(type, stepId)
			
		
		$.ajax({
			url: url,
			type: 'POST',
			data: {medium: {'image_id': imgId }}
		}).done(function(a){


		})
	}

	function setButtonStates(count){
		console.log(totalNumPicts, pages, count, clickCount)
		if(clickCount == 0){
			console.log("disable prev")
			$('#prev').attr('disabled', 'disabled')
			$('#next').removeAttr('disabled');
			// return;
		}
		if(clickCount > 0 && clickCount <= pages){
			$('#prev').removeAttr('disabled');
			$('#next').removeAttr('disabled');
			// return;
		}
		if(clickCount == pages){
			console.log('disable next page')
			$('#next').attr('disabled', 'disabled');
			// return;
		}
	}

	function getImages(count, numPict){
		code = code || $('#location_select').val();
		$.ajax({
			type: "GET",
			data: {count: count, numPict: numPict, code: code},
			url: '/api/get_images.json',
			// url: "/images.json"
		}).done(function(data){
			$('.imgHolder').empty();
			$('.imgHolder').append('<div class="row c"></div')
			$('.imgHolder').append('<div class="row container2"></div>')

			for(var i = 0; i < data.length; i++){
				if(i > 2){
					$('.container2').append("<div class='col-sm-4'><img class='m' data-img-m='" + data[i]['id'] + "' src='" + data[i].imgUrl + "'></div>");

				}else{
					$('.c').append("<div class='col-sm-4'><img class='m' data-img-m='" + data[i]['id'] + "' src='" + data[i].imgUrl + "'></div>");
				}
				totalNumPicts = data[i]['totalCount'];
				pages = Math.ceil(totalNumPicts / numPict) - 1;
			}
			setButtonStates(count);
		})
	}

}
$(document).ready(ready);
$(document).on('page:load', ready)