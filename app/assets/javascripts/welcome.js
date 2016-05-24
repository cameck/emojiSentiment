//Hide and show the search icon on click for the home page search box
$(document).ready(function(){
  // Add the Anchor Link home so Full page JS works with Back Button

  if (window.location.hash == "" && window.location.pathname == "/") {
    window.location.hash = "#Home";
  }

  var notMobileWindowSize = window.matchMedia( "(max-width: 768px)" ).matches;
  var fullPage = function() {
    $('#fullpage').fullpage({
    anchors: ['Home', 'Why', 'About', 'Contact'],
    navigation: true,
    navigationPosition: 'right',
    navigationTooltips: ['Home', 'Why', 'About', 'Contact'],
    recordHistory: true,
  });
};

  if (!notMobileWindowSize) {
    // Initialize Full Page JS
    fullPage();
    fullPage = function(){};
  }

  function resize() {
    if (window.innerWidth > 768) {

      $(".fullpageJS").attr("id", 'fullpage');
      fullPage();
      fullPage = function(){};
    } else {
      $(".fullpageJS").removeAttr("id");
    }
  }
  resize();

  window.onresize = resize;
  // Add and Replace font awesome icon when clicking on and off the search field
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
      $('#fp-nav').hide('slow');
      $.post("/results/");
    }
  });
  //Hide Detailed emoji data on page load
  $('#topEmoji').hide();
  $('#secondPlaceEmoji').hide();
  $('#thirdPlaceEmoji').hide();

  // Hide and Show Emoji data depending on click location
  $('#sentiment-0').click(function() {
    $('#secondPlaceEmoji').slideUp();
    $('#thirdPlaceEmoji').slideUp();
    $('#topEmoji').slideToggle();
  });
  $('#sentiment-1').click(function() {
    $('#topEmoji').slideUp();
    $('#thirdPlaceEmoji').slideUp();
    $('#secondPlaceEmoji').slideToggle();
  });
  $('#sentiment-2').click(function() {
    $('#topEmoji').slideUp();
    $('#secondPlaceEmoji').slideUp();
    $('#thirdPlaceEmoji').slideToggle();
  });

  // Popup for show page
  $('#sentiment-data-popup').hide();
  var options = { content : $('#sentiment-data-popup') };
  $('.agregate_sentiment_board').popup(options);

  //counter animation
  $('.count').each(function () {
    var $this = $(this);
    jQuery({ Counter: 0 }).animate({ Counter: $this.text() }, {
      duration: 1000,
      easing: 'swing',
      step: function () {
        $this.text(this.Counter.toFixed(2));
      }
    });
  });

  // caret progress bar animation
  $('.progress-caret').each(function () {
    var $this = $(this);
    var marginSize = parseFloat($this[0].nextSibling.innerText);
    $($this).animate({ marginLeft:  marginSize + "%" }, 1000, "swing");
  });


  // fade in/out Pages
  var fadeOutShowPage = function(anchorTag) {
    $('#show-page').fadeOut('slow', function() {
      window.location = '/#' + anchorTag;
    });
  };

  $('#show-page').fadeIn(1000);
  $('#fullpage').hide();
  $('#fullpage').fadeIn(2000);

  // Handle smoothness of transition from rails page to full page js
  $('.show-nav').click(function(e) {
    e.preventDefault();

    if ( $(this).hasClass("home") ) {
      fadeOutShowPage("Home");
    } else if ( $(this).hasClass("why") ) {
      fadeOutShowPage("Why");
    } else if ( $(this).hasClass("about") ) {
      fadeOutShowPage("About");
    } else if ( $(this).hasClass("contact") ) {
      fadeOutShowPage("Contact");
    } else {
      fadeOutShowPage("Home");
    }
  });


});
