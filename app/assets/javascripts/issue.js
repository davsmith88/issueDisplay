
$(document).ready(function(){

	
	$('.detailed-step-info-section').hide();
	
	$('body').on('click', '.down_arrow', function(e){
		var hidden_section = $(this).parent().find('.detailed-step-info-section')[0];
		$(hidden_section).toggle(250);

		console.log('clicked on c', hidden_section, this)
	})

	$('body').on('click','#search_click', function(e){
		// var id = $(this).val();
		var id = $('#l-issue-select').val();
		var search_term = $('#searchbox').val();

		if(search_term.length === 0 && id === 'all'){
				window.location.href = '/issues'
			}else if(id == 'all' && search_term.length > 0){
				window.location.href = '/issues?search=' + search_term
			}else{
				window.location.href = '/issues?loc=' + id + '&search=' + search_term
			}
	})

	$('.issues.show').ready(function(){
		$('#navbar').children().first().addClass('active')
		$('#side_section').find('.tab-content').children().first().addClass('active in')
		


		el = document.getElementById('detailed_steps');
	
		sortable = Sortable.create(el, {
		
			onSort: function(evt){
				console.log('moved item')

				var data = {};
				var issueId = parseInt($('#issueId').text());
				var list = $('#detailed_steps').children();
				
				$.each(list, function(index, value){
					var id = $(value).data('ds-id');
					var step_num = index + 1
					data[id] = { number: step_num }
				})
			
				$.ajax({
					url: '/issues/' + issueId + '/detailed_steps/step_number_update.json',
					data: data,
					method: 'POST'
				}).done(function(html){
					var list = $('#detailed_steps').children()
					$.each(list, function(index, value){
						var item = $(value).find('.moveItem').first();
						$(value).find('.moveItem').text(index + 1);
					})
				})

			}
		});

		$('body').on('click', '.sm-img', function(e){
			// on click of the thumbnail, will open a modal with the large image attached
			var target = $(e.target)
			var bigImgUrl = target.parent().data('big-img')
			var name = target.parent().data('big-img-name')
			var caption = target.parent().data('big-img-caption')
			
			$('#large-image').attr('src', bigImgUrl)
			$('#model-name').text(name)
			$('#model-caption').text(caption)
			$('#myModalBigImage').modal('show')
		})
		$('#showOther').click(function(e){
			e.preventDefault();
			console.log("click show-other-fields")
			$('.show-hidden').toggleClass('hidden-xs');
		})
	})
})


function createSortable(){
			el = document.getElementById('detailed_steps');
		

		sortable = Sortable.create(el, {
			disabled: true,
			onSort: function(evt){
				console.log('moved item')

				var data = {};
				var issueId = parseInt($('#issueId').text());
				var list = $('#detailed_steps').children();
				
				$.each(list, function(index, value){
					var id = $(value).data('ds-id');
					var step_num = index + 1
					data[id] = { number: step_num }
				})
			
				$.ajax({
					url: '/issues/' + issueId + '/detailed_steps/step_number_update.json',
					data: data,
					method: 'POST'
				}).done(function(html){
					var list = $('#detailed_steps').children()
					$.each(list, function(index, value){
						var item = $(value).find('.moveItem').first();
						$(value).find('.moveItem').text(index + 1);
					})
				})

			}
		});
return sortable
}

function create_sortable_list(){
		var el = document.getElementById('detailed_steps');
		

		var sortable = Sortable.create(el, {

			onSort: function(evt){
				console.log('moved item')

				var data = {};
				var issueId = parseInt($('#issueId').text());
				var list = $('#detailed_steps').children();
				
				$.each(list, function(index, value){
					var id = $(value).data('ds-id');
					var step_num = index + 1
					data[id] = { number: step_num }
				})
			
				$.ajax({
					url: '/issues/' + issueId + '/detailed_steps/step_number_update.json',
					data: data,
					method: 'POST'
				}).done(function(html){
					var list = $('#detailed_steps').children()
					$.each(list, function(index, value){
						var item = $(value).find('.moveItem').first();
						$(value).find('.moveItem').text(index + 1);
					})
				})
			}
		});
}