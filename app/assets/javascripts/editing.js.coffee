myNicEditor = undefined
savedBodyPadding = undefined
editables = undefined
previewStatus = false
bodyOffsetForAdminPanel = "90px"

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel "myNicPanel"
  editables.each (index) ->
    myNicEditor.addInstance $(this).attr("id")

save = ->
  contents = {}
  editables.each ->
    contents[$(this).attr("id")] = $(this).html()
  params =
    contents: contents
    meta_title: "Hello"
  path = window.location.pathname.replace("/edit", "")
  path = "/" if path == ""
  $.post(path, params, (data) ->
    #alert data #TODO something else
    alert "TODO: I think it saved. I need to add an ajax error handler. And a fancy tooltip message"
  ).error ->
    alert "We're sorry, an error occured while saving"

preview = ->
  #$("#myNicPanel").hide()
  #$(this).addClass("success")
  #$(this).removeClass("primary")
  
  if previewStatus
    previewStatus = false
    editables.addAttr("contenteditable")
    $("#adminPanel").show()
    $("body").css("padding-top", bodyOffsetForAdminPanel)
  else
    previewStatus = true
    editables.removeAttr("contenteditable")
    $("#adminPanel").hide()
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

attachAdminHandlers = (adminPanel) ->
  adminPanel.find("button").each ->
    _function = $(this).attr("data-click")
    $(this).click eval(_function) if _function

jQuery ->
  adminPanel = $("#adminPanel")
  if adminPanel.length > 0
    editables = $(".editable")
    initNicPanels adminPanel
    attachAdminHandlers adminPanel
    savedBodyPadding = $("body").css("padding-top")
    $("body").css("padding-top", bodyOffsetForAdminPanel)
    

