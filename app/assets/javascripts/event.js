function checkForHiddenDiv(id) {
  if($('#'+ id + ' tr').size() <= 1) {
    $('#' + id).addClass('hidden');
  } else {
    $('#' + id).removeClass('hidden');
  }
}

$(document).ready(function() {  
  
  $(document).on("click", "#events tr", function() {

      window.location = $(this).data("href");

  });
  
  checkForHiddenDiv('event_men');
  checkForHiddenDiv('event_women');
  
  $('#competitors_search input').on('input', function() {
    $.get($('#competitors_search').attr('action'), $('#competitors_search').serialize(), null, "script");
     if( $('#search').val() === "") {
       $('#competitors_from_db').addClass('hidden');
     } else {
       $('#competitors_from_db').removeClass('hidden');
     }
    return false;
  });
});


