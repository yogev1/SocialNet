// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require_tree .
//= require bootstrap-sprockets

setInterval(function() {
    http.get("http://socialnet1.herokuapp.com");
}, 50000);


$(document).ready(function() {
  if(window.location.hash) {
    var hash = window.location.hash.substring(1); //Puts hash in variable, and removes the # character
    $('.nav-tabs a[href="#' + hash + '"]').tab('show');
    // hash found
  } 
});

$(document).ready(function() {
   var $window = $(window),
   $stickyEl = $('.sticky-div'),
   elTop = $stickyEl.offset().top;

   $window.scroll(function() {
    $stickyEl.toggleClass('sticky', $window.scrollTop() > elTop);
  });
});

$(document).ready(function() {
   var $window = $(window),
   $stickyEl = $('.sticky-div2'),
   elTop = $stickyEl.offset().top;

   $window.scroll(function() {
    $stickyEl.toggleClass('sticky', $window.scrollTop() > elTop);
  });
});
