# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$( document ).ready(-> 
 	$('#btn-createNewIssue').on("click", -> 
	    console.log('click btn-createNewIssue')
	    $('#myModal').modal("show")
	)
);