$( document ).ready(function() {
console.log("loaded javascript file")

  // hide spinner
  $(".sk-circle").hide();


	$("#submit").click(function() {
	 console.log("ajaxStart fired!");
	});

  // show spinner on AJAX start
  $(document).ajaxStart(function(){
    $(".sk-circle").show();
  });

  // hide spinner on AJAX stop
  $(document).ajaxStop(function(){
    $(".sk-circle").hide();
  });

});

// $( document ).ready(function() {

// $(".sk-circle").hide();
// });

// $(document).on("page:fetch", function(){
//   $(".spinner").show();
// });

// $(document).on("page:receive", function(){
//   $(".spinner").hide();
// });