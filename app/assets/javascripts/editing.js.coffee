adminPanel = undefined
myNicEditor = undefined
nicEditorDiv = undefined
savedBodyPadding = undefined
editables = undefined
adminAlert = undefined
bodyOffsetForAdminPanel = "80px"
metaTitle = undefined
metaDesc = undefined
metaAuthor = undefined

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
    adminAlert.addClass("alert-message block-message success");
    #adminAlert.find('.message').append(
    adminAlert.find('.message').html(
      'Successfully saved <div class="alert-actions">
        <a class="btn small" data-click="closeAdminAlert">Close</a>
      </div>')
    attachHandlersToAlertBlockButtons()
    adminAlert.show()
    nicEditorDiv.hide()
  ).error ->
    adminAlert.addClass("alert-message error");
    adminAlert.find('.message').html("We're sorry, an error has occured while saving.")
    adminAlert.show()
    nicEditorDiv.hide()

preview = ->
  editables.removeAttr("contenteditable")
  adminPanel.slideUp()
  $("body").css("padding-top", savedBodyPadding)
  $("#expandAdminPanel").show("slow")

previewEnd = ->
  #alert("hello")
  $("#expandAdminPanel").hide()
  $("body").css("padding-top", bodyOffsetForAdminPanel)
  adminPanel.slideDown()
  editables.attr("contenteditable", "true")

discard = ->
  nicEditorDiv.hide()
  adminAlert.addClass("alert-message block-message info")
  adminAlert.find('.message').html("Are you sure you want to discard your changes?")
  adminAlert.find('.message').append(
    '<div class="alert-actions">
      <a class="btn small" data-click="reloadPage">Yes, discard the changes</a> 
      <a class="btn small" data-click="closeAdminAlert">No, keep my changes</a>
    </div>')
  attachHandlersToAlertBlockButtons()
  adminAlert.show()


meta = ->
  nicEditorDiv.hide()
  adminAlert.addClass("alert-message block-message info")
  #adminAlert.find('.message').html("Are you sure you want to discard your changes?")
  adminAlert.find('.message').html(
    '<div class="alert-actions"><form><fieldset>
      <div class="clearfix">
        <label for="title">Title</label>
        <div class="input"><input name="title" size="30" type="text"></div>
      </div>
      <div class="clearfix">
        <label for="desc">Description</label>
        <div class="input"><input name="desc" size="30" type="text"></div>
      </div>
      <div class="clearfix">
        <label for="desc">Author</label>
        <div class="input"><input name="author" size="30" type="text"></div>
      </div>
    </fieldset></form></div>')
    
    #</div>
    #<div class="alert-actions">
    #<a class="btn small" data-click="reloadPage">Yes, discard the changes</a> 
#      <a class="btn small" data-click="closeAdminAlert">No, keep my changes</a>
  #attachHandlersToAlertBlockButtons()
  adminAlert.show()


attachHandlersToAlertBlockButtons = ->
  adminPanel.find(".message").find("a").each ->
    _function = $(this).attr("data-click")
    $(this).click eval(_function) if _function

closeAdminAlert = ->
  adminAlert.removeClass()
  adminAlert.hide()
  nicEditorDiv.show()

reloadPage = ->
  $(".container").html("Reloading...")
  window.location.reload()

notyetimplemented = ->
  alert "Sorry, not yet implemented"

attachAdminButtonHandlers = ->
  adminPanel.find("button").each ->
    _function = $(this).attr("data-click")
    $(this).click eval(_function) if _function

attachAdminAlertCloseHandler = ->
  adminAlert.find(".close").click ->
    closeAdminAlert()
    
attachExpandHandler = ->
  $("#expandAdminPanel").click(previewEnd)

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel("myNicPanel")
  nicEditorDiv = $("#myNicPanel")
  editables.each (index) ->
    myNicEditor.addInstance($(this).attr("id"))

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

