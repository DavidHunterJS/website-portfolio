'use strict';
$('#fullpage').fullpage({
  scrollOverflow: true,
  anchors: ['section1', 'section2', 'section3', 'section4'],
  menu: '#menu',
  css3: true,
  continuousVertical: false,
  resize: false
});

$('#theForm').submit(function(e) {
  var data;
  data = $('#theForm').serialize();
  e.preventDefault();
  $.ajax({
    url: 'http://127.0.0.1:8181/myAction',
    type: 'POST',
    data: data,
    processData: false,
    success: function() {
      var originalHtml;
      console.log('Success');
      $('#theForm').trigger('reset');
      originalHtml = $('#messageArea').html();
      $('#messageArea').fadeOut(800, function() {
        $(this).html('Thank you! ' + '<small>' + 'Your message was sent successufully.' + '</small>').fadeIn(800).css({
          'color': 'rgb(126,0,0)'
        }).delay(3000);
        $(this).fadeOut(1500, function() {
          $(this).html(originalHtml).css({
            'color': 'aliceblue'
          }).fadeIn(1500);
        });
      });
    },
    error: function(xhr, status, error) {
      console.log(xhr, error);
    }
  });
});
