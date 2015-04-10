'use strict'
$('#theForm').submit (e) ->
  
  # grabs the form's input values
  data = $('#theForm').serialize()

  # Stops the form from auto submitting so I can do stuff in the ajax below
  e.preventDefault()
  
  $.ajax
    # the express server location
    url: 'http://127.0.0.1:8181/myAction'
    type: 'POST'
    data: data
    processData: false
    
    success: (data) -> # remove data args
      console.log 'Success' # you did it, you magnificent s.o.b.
      # clears the form of input values when successful
      $('#theForm').trigger 'reset'
      # success message to the user using the DOM
      # stores original html/text to replace message
      originalHtml = $('#messageArea').html()
      # fades out original message
      $('#messageArea').fadeOut 800, ->
        $(this).html('Thank you! ' + '<small>' + 'Your message was sent successufully.' + '</small>')
          .fadeIn(800)
          .css('color':'rgb(126,0,0)')
          .delay 3000
        $(this).fadeOut 1500, ->
          $(this).html(originalHtml).css('color': 'aliceblue').fadeIn 1500
          return
        return
      return
    
    error: (xhr, status, error) ->
      console.log xhr, error
      return
  return

