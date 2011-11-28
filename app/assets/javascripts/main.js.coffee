# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  
  $('form#login').submit ->
      # alert $(@).attr('action')
      $.post(
        $(@).attr('action') 
        $(@).serialize()
        (result) ->
          r = $.parseJSON result.replace("[", "").replace("]", "")
          if r.login is 'invalid'
            $("#flashWrap").fadeIn(400)
          else
            logout = $('#logoutContainer')
            logout.find('#message').html("Logged in as " + r.user)
            $('#loginContainer').hide()
            $('#logoutContainer').show()
        )
      return false
    
    $('#logout').click ->
      $.post $(@).attr('href') #, (result) ->
      $('#logoutContainer').hide()
      $('#loginContainer').show()
      return false

  # Slider
  $("#mainSlider").scrollable
      next: "#sliderBtnNext"
      prev: "#sliderBtnPrev"
      circular: true

  # Menu 
  $("#nav li a").click ->
    alert 'Coming Soon'
    return false
        
  # $("#login > #loginBtn").click ->
  #     # $("#flashWrap").toggle()
  #     $("#flashWrap").fadeIn(300)
  #     return false
  $('img#close').click ->
    $("#flashWrap").fadeOut(300)
  
