//Hide and show the search icon on click for the home page search box
$(document).ready(function(){
  $(".searchfield").focus(function() {
    console.log("this works!")
      $(this).removeAttr('value');
  }).blur(function() {
    $(this).attr('value');
  })
});
