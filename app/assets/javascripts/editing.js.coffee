adminPanel = undefined
myNicEditor = undefined
savedBodyPadding = undefined
editables = undefined
adminAlert = undefined
bodyOffsetForAdminPanel = "90px"

save = ->
  contents = {}
  editables.each ->
    contents[$(this).attr("id")] = $(this).html()
  params =
    contents: contents
    #meta_title: "Hello"
  path = window.location.pathname.replace("/edit", "")
  path = "/" if path == ""
  $.post(path, params, (data) ->
    adminAlert.addClass("alert-message success");
    adminAlert.find('.message').html('Successfully saved')
    adminAlert.show()
  ).error ->
    adminAlert.addClass("alert-message error");
    adminAlert.find('.message').html("We're sorry, an error has occured while saving.")
    adminAlert.show()

preview = ->
  editables.removeAttr("contenteditable")
  adminPanel.hide()
  $("body").css("padding-top", savedBodyPadding)
  $("#expandAdminPanel").show()

previewEnd = ->
  #alert("hello")
  $("#expandAdminPanel").hide()
  $("body").css("padding-top", bodyOffsetForAdminPanel)
  adminPanel.show()
  editables.attr("contenteditable", "true")

discard = ->
  answer = confirm("Are you sure you want to discard your changes?")
  $(".container").html("Reloading...")
  window.location.reload() if answer

notyetimplemented = ->
  alert "Sorry, not yet implemented"

attachAdminButtonHandlers = ->
  adminPanel.find("button").each ->
    _function = $(this).attr("data-click")
    $(this).click eval(_function) if _function

attachAdminAlertCloseHandler = ->
  adminAlert.find(".close").click ->
    adminAlert.removeClass()
    adminAlert.hide()
    
attachExpandHandler = ->
  $("#expandAdminPanel").click(previewEnd)

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel "myNicPanel"
  editables.each (index) ->
    myNicEditor.addInstance $(this).attr("id")

initAdmin = ->
  adminPanel = $("#adminPanel")
  if adminPanel.length > 0
    adminAlert = adminPanel.find('#alert')
    editables = $(".editable")
    initNicPanels()
    savedBodyPadding = $("body").css("padding-top")
    $("body").css("padding-top", bodyOffsetForAdminPanel)
    attachAdminButtonHandlers()
    attachAdminAlertCloseHandler()
    attachExpandHandler()

jQuery ->
  initAdmin()


