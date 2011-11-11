# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  
  # Slider
  $("#mainSlider").scrollable
      next: "#sliderBtnNext"
      prev: "#sliderBtnPrev"
      circular: true

  # Menu 
  $("#nav li a").click ->
    alert 'hello'
    return false


