$(document).ready(function() {

  $(".tab").click(function() {

  var x = $(this).attr('id');

    if (x == 'admin') {
      $("#student").removeClass('select');
      $("#admin").addClass('select')
      $("#studentbox").slideUp();
      $("#adminbox").slideDown();
    } else {
      $("#admin").removeClass('select');
      $("#student").addClass('select');
      $("#adminbox").slideUp();
      $("#studentbox").slideDown();
    }
  });
});