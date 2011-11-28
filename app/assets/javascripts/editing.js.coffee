adminPanel = undefined
myNicEditor = undefined
savedBodyPadding = undefined
editables = undefined
previewStatus = false
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
  if previewStatus
    previewStatus = false
    editables.addAttr("contenteditable")
    adminPanel.show()
    $("body").css("padding-top", bodyOffsetForAdminPanel)
  else
    previewStatus = true
    editables.removeAttr("contenteditable")
    adminPanel.hide()
    $("body").css("padding-top", savedBodyPadding)
    alert "TODO: I still need to add a button to end preview. For now you'll have to refresh'"
  
  #instances = myNicEditor.nicInstances
  #i = 0
  #while i < instances.length
    #alert instances[i].e
    #instances[i].remove()
    #myNicEditor.nicInstances.splice i, 1
    #i++
  
  #$(".editable").each (index) ->
  #  alert $(this).attr("id")
  #  myNicEditor.removeInstance $(this).attr("id")
  #var instances = this.nicInstances;
	#	for(var i=0;i<instances.length;i++) {	
	#		if(instances[i].e == e) {
	#			instances[i].remove();
	#			this.nicInstances.splice(i,1);
	#		}
	#	}
  #alert "you clicked preview. I should remove the contentEditables."

discard = ->
  alert "you clicked discard. I have no idea how to do that yet. Probably reload from server?"

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

jQuery ->
  initAdmin()

