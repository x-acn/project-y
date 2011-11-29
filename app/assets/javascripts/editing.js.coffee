adminPanel = undefined
adminAlert = undefined
adminMessage = undefined
myNicEditor = undefined
nicEditorDiv = undefined
savedBodyPadding = undefined
editables = undefined
bodyOffsetForAdminPanel = "80px" ##TODO dynamically change the offset based on topbar size and changes
metaTitle = undefined
metaDesc = undefined
metaAuthor = undefined
currentTemplate = undefined

save = ->
  contents = {}
  editables = $('.editable')
  editables.each ->
    contents[$(this).attr("id")] = $(this).html()
  params =
    contents: contents
    template: currentTemplate
  path = window.location.pathname.replace("/edit", "/update")
  $.post(path, params, (data) ->
    adminAlert.addClass("alert-message block-message success");
    adminMessage.html(
      'Successfully saved <div class="alert-actions">
        <a class="btn small" data-click="closeAdminAlert">Close</a>
      </div>')
    attachHandlersToAlertBlockButtons()
    adminAlert.show()
    nicEditorDiv.hide()
  ).error ->
    adminAlert.addClass("alert-message error");
    adminMessage.html("We're sorry, an error has occured while saving.")
    adminAlert.show()
    nicEditorDiv.hide()

preview = ->
  editables.removeAttr("contenteditable")
  adminPanel.slideUp()
  $("body").css("padding-top", savedBodyPadding)
  $("#expandAdminPanel").show("slow")

previewEnd = ->
  $("#expandAdminPanel").hide()
  $("body").css("padding-top", bodyOffsetForAdminPanel)
  adminPanel.slideDown()
  editables.attr("contenteditable", "true")

discard = ->
  nicEditorDiv.hide()
  adminAlert.addClass("alert-message block-message info")
  adminMessage.html("Are you sure you want to discard your changes?")
  adminMessage.append(
    '<div class="alert-actions">
      <a class="btn small" data-click="reloadPage">Yes, discard the changes</a> 
      <a class="btn small" data-click="closeAdminAlert">No, keep my changes</a>
    </div>')
  attachHandlersToAlertBlockButtons()
  adminAlert.show()


meta = ->
  nicEditorDiv.hide()
  adminAlert.addClass("alert-message block-message info")
  adminMessage.html(
    '<div class="alert-actions"><form><fieldset>
      <legend>Page Details</legend>
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
      </fieldset>
      <fieldset>
      <legend>Site Details</legend>
      <div class="clearfix">
        <label for="desc">Subdomain</label>
        <div class="input"><input name="subdomain" size="30" type="text"></div>
      </div>
    </fieldset></form></div>')
    
    #</div>
    #<div class="alert-actions">
    #<a class="btn small" data-click="reloadPage">Yes, discard the changes</a> 
#      <a class="btn small" data-click="closeAdminAlert">No, keep my changes</a>
  #attachHandlersToAlertBlockButtons()
  adminAlert.show()


templates = undefined

getTemplatesAndShow = ->
  if templates
    showTemplates()
  else
    $.get "/templates.json", (data) ->
      templates = data
      showTemplates()

showTemplates = ->
  nicEditorDiv.hide()
  adminAlert.addClass("alert-message block-message info")
  adminMessage.html("<div class='alert-actions'><strong>Warnings/Instructions:
  <ul>
    <li>You will lose any unsaved work when selecting a new template.</li>
    <li>Click 'Save' to apply template changes</li>
    <li>When changing from a 3 column to 2 column layout you will lose content from 1 column (after saving).</li>
  <ul>
  <br/></div>")
  alertActions = adminAlert.find('.alert-actions')
  i = 0
  while i < templates.length
    template = templates[i++]
    alertActions.append("<a class='btn small' data-click='applyTemplate' data-template='#{ template.filename }'>#{ template.title }</a> ")
  alertActions.append("")
  attachHandlersToAlertBlockButtons()
  adminAlert.show()

pageTemplate = ->
  getTemplatesAndShow()

applyTemplate = (name) ->
  path = window.location.pathname.replace("/edit", "")
  params = { template: $(this).attr("data-template") }
  $.get(path, params, (data) ->
    currentTemplate = params.template #used in save action
    $('body > .container').html(data)
    ## TODO copy content from existing editables in order to avoid loosing work
    removeAllNicInstances()
    $(data).find('.editable').each ->
      myNicEditor.addInstance($(this).attr("id"))
  ).error ->
    adminAlert.removeClass()
    adminAlert.addClass("alert-message error");
    adminMessage.html("We're sorry, an error has occured while fetching the template.")
    adminAlert.show()
    nicEditorDiv.hide()

siteTheme = ->
  notyetimplemented()

attachHandlersToAlertBlockButtons = ->
  adminMessage.find(".btn").each ->
    functionName = $(this).attr("data-click")
    $(this).click eval(functionName) if functionName

closeAdminAlert = ->
  adminMessage.html("")
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
    functionName = $(this).attr("data-click")
    $(this).click eval(functionName) if functionName

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel("myNicPanel")
  nicEditorDiv = $("#myNicPanel")
  editables.each ->
    myNicEditor.addInstance($(this).attr("id"))

removeAllNicInstances = ->
  instances = myNicEditor.nicInstances
  i = 0; length = instances.length
  while i < length
    instances[i++].remove()
  myNicEditor.nicInstances.splice(0, length)

initAdmin = ->
  adminPanel = $("#adminPanel")
  if adminPanel.length > 0
    adminAlert = adminPanel.find('#alert')
    adminMessage = adminAlert.find('.message')
    editables = $(".editable")
    initNicPanels()
    savedBodyPadding = $("body").css("padding-top")
    $("body").css("padding-top", bodyOffsetForAdminPanel)
    attachAdminButtonHandlers()
    adminAlert.find(".close").click(closeAdminAlert)
    $("#expandAdminPanel").click(previewEnd)

jQuery ->
  initAdmin()

