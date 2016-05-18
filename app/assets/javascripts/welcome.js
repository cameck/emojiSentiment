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
      // When ajaxStart is fired, add 'loading' to body class
      ajaxStart: function() {
          $("body").addClass("loading");
      }

  });

  // Initiates an AJAX request on pressing enter
  $(document).keypress(function(e){
    var key = e.which;
    if (key == 13) {
      console.log("YOLO");
      $.post("/index/");
    }
  });
});
