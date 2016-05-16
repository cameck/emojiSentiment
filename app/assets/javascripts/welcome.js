//Hide and show the search icon on click for the home page search box
$(document).ready(function(){
  $(".searchfield").focus(function() {
      $(this).attr('value', "");
      $(this).css('font-family', 'proxima-nova, sans-serif');
  }).blur(function() {
    var searchIcon = "&#xf002;";
    var $searchIcon = $($.parseHTML(searchIcon));
    $(this).css('font-family', 'FontAwesome');
    $(this).attr('value', $searchIcon.text() );
  });
});
