$(document).ready(function() {
	console.log("ready");

  //hide spinner
  $(".sk-circle").hide();



  // show spinner on submit click
  $("#submit").click(function(){
    $(".sk-circle").show();
  });

  // hide spinner on AJAX stop
  // $(document).ajaxStop(function(){
  //   $(".sk-circle").hide();
  // });

});
