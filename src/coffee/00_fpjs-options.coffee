# fullpage.js options

'use strict'

$('#fullpage').fullpage
  scrollOverflow: true # lets you scroll when the text overflows the viewport
  anchors: [ # defines the anchor links for each section
    'section1'
    'section2'
    'section3'
    'section4'
  ]
  menu: '#menu' # will add the active class to the element with the corresponding anchor link
  css3: true # use CSS3 transforms to scroll within sections and slides when available
  continuousVertical: false # scrolling down in the last section will not scroll to the first section
  resize: false # text will not rezise on small screens