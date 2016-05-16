//Hide and show the search icon on click for the home page search box
$(document).ready(function(){
  $(".searchfield").focus(function() {
      $(this).removeAttr('value');
  }).blur(function() {
    var searchIcon = "&#xf002; #";
    var $searchIcon = $($.parseHTML(searchIcon));
    $(this).attr('value', $searchIcon.text() );
  });
});
