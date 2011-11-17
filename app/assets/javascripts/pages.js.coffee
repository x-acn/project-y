myNicEditor = undefined

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel "myNicPanel"
  $(".editable").each (index) ->
    myNicEditor.addInstance $(this).attr("id")

save = ->
  contents = {}
  $(".editable").each ->
    contents[$(this).attr("id")] = $(this).html()
  params =
    contents: contents
    meta_title: "Hello"
  #TODO get the current url slug instead of hardcoded 'hello'
  $.post "hello", params, (data) ->
    #alert data #TODO something else
    alert "TODO: I think it saved. I need to add an ajax error handler. And a fancy tooltip message"

previewStatus = false
preview = ->
  #alert "handling preview. ideally do this with just css"
  #alert myNicEditor
  #$(".editable").css
  #document.designmode = "off"
  
  #$("#myNicPanel").hide()
  #$(this).addClass("success")
  #$(this).removeClass("primary")
  
  if previewStatus
    previewStatus = false
  else
    previewStatus = true
    $(".editable").removeAttr("contenteditable")
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

savedBodyPadding = undefined
jQuery ->
  adminPanel = $("#adminPanel")
  if adminPanel.length > 0
    initNicPanels adminPanel
    attachAdminHandlers adminPanel
    savedBodyPadding = $("body").css("padding-top")
    $("body").css("padding-top", "90px")
    

