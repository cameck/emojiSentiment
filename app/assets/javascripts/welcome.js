//Hide and show the search icon on click for the home page search box
$(document).ready(function(){
  $('.modal-trigger').leanModal();
  $(".searchfield").focus(function() {
      $(this).attr('value', "");
      $(this).css('font-family', 'proxima-nova, sans-serif');
  }).blur(function() {
    var searchIcon = "&#xf002;";
    var $searchIcon = $($.parseHTML(searchIcon));
    $(this).css('font-family', 'FontAwesome');
    $(this).attr('value', $searchIcon.text() );
  });


  $(document).on({
      // When ajaxStart is fired, add 'loading' to body class - will stop once new page loads
      ajaxStart: function() {
          $("body").addClass("loading");
      }
  });

  // Initiates an AJAX request on pressing enter on home page twitter request
  $(document).keypress(function(e){
    var key = e.which;
    if ( key == 13 && $.trim($("#hash_tag").val()) ) {
      $.post("/index/");
    }
  });

  $('#topEmoji').hide();
  $('#secondPlaceEmoji').hide();
  $('#thirdPlaceEmoji').hide();

  $('#sentiment-0').click(function() {
    $('#secondPlaceEmoji').slideUp();
    $('#thirdPlaceEmoji').slideUp();
    $('#topEmoji').slideDown();
  });
  $('#sentiment-1').click(function() {
    $('#topEmoji').slideUp();
    $('#thirdPlaceEmoji').slideUp();
    $('#secondPlaceEmoji').slideDown();
  });
  $('#sentiment-2').click(function() {
    $('#topEmoji').slideUp();
    $('#secondPlaceEmoji').slideUp();
    $('#thirdPlaceEmoji').slideDown();
  });
});
