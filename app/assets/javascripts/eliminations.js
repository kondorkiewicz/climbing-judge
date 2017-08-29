document.addEventListener("turbolinks:load", function() {
  
  $('#buttons').children().each(function(index) {
    $(this).on("click", function(e) {
      e.preventDefault();
      var tabId = $(this).attr('id').substr(0, 2)
      $('#' + tabId).slideToggle('slow');
      $(this).toggleClass('active');
    });
  });
  
});

  

  
  


