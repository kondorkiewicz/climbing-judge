document.addEventListener("turbolinks:load", function() {
  
  $('#m-btn').click(function(e) {
    e.preventDefault();
    $('#m').slideToggle('slow'); 
  });
  
  $('#f-btn').click(function(e) {
    e.preventDefault();
    $('#f').slideToggle('slow');  
  });
  
});