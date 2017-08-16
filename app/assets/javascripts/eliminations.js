$(document).ready(function() {
  
  $('#m1-btn').click(function(e) {
    e.preventDefault();
    $('#m1').slideToggle('slow'); 
    //$('#m1_res').slideToggle('slow'); 
  });
  
  $('#f1-btn').click(function(e) {
    e.preventDefault();
    $('#f1').slideToggle('slow');  
    //$('#f1_res').slideToggle('slow');
  });
  
  $('#m2-btn').click(function(e) {
    e.preventDefault();
    $('#m2').slideToggle('slow');
    //$('#m2_res').slideToggle('slow');  
  });
  
  $('#f2-btn').click(function(e) {
    e.preventDefault();
    $('#f2').slideToggle('slow');  
    //$('#f2_res').slideToggle('slow');
  });
  
  

});
