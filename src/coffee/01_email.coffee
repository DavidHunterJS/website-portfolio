#   This is the client side portion of the email contact form.
#   It grabs the form data from the DOM and sends it to an emailjs server to be delivered.
$('#theForm').submit (e) ->
  
  data = $('#theForm').serialize() # grabs the form's input values
  e.preventDefault() # stops the form from auto submitting so I can do stuff in the ajax below
  
  $.ajax
    url: 'http://127.0.0.1:8182/myAction' # the express server location
    type: 'POST' # method used to add data to the server
    data: data # data is named data
    processData: false # the data will not be processed as a query string
    
    success: () -> # things to do when ajax is successful
      console.log 'Success' # you did it, you magnificent s.o.b.
      $('#theForm').trigger 'reset' # clears the form of input values when successful
      
      # success message to the user letting them know the email has been sent successfully
      originalHtml = $('#messageArea').html() # stores original html/text to replace message
      $('#messageArea').fadeOut 800, -> # fades out original message
        $(this).html('Thank you! ' + '<small>' + 'Your message was sent successufully.' + '</small>') # thank you message
          .fadeIn(800) # fades in thank you message
          .css('color':'rgb(126,0,0)') # text color is different
          .delay 3000 # delay keeps the messgage on the screen for 3 seconds
        $(this).fadeOut 1500, -> # fade out thank you message
          $(this).html(originalHtml).css('color': 'aliceblue').fadeIn 1500 # fade back in original text
          return
        return
      return
    
    error: (xhr, status, error) ->
      console.log xhr, error
      return
  return

