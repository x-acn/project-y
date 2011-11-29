adminPanel = undefined
myNicEditor = undefined
nicEditorDiv = undefined
savedBodyPadding = undefined
editables = undefined
adminAlert = undefined
bodyOffsetForAdminPanel = "80px" ##TODO dynamically change the offset absed on topbar size
metaTitle = undefined
metaDesc = undefined
metaAuthor = undefined
currentTemplate = undefined

save = ->
  contents = {}
  editables.each ->
    contents[$(this).attr("id")] = $(this).html()
  params =
    contents: contents
    template: currentTemplate
  path = window.location.pathname.replace("/edit", "/update")
  $.post(path, params, (data) ->
    adminAlert.addClass("alert-message block-message success");
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
  adminAlert.find('.message').html("<div class='alert-actions'><strong>WANRING: You will lose any unsaved work when selecting a new template.</strong>
  <br/>Click 'Save' to apply template changes. For now, do not make any content changes between choosing a template and saving.
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
    editables = $(data).find('.editable')
    $('body > .container').html(data)
    editables.each ->
      myNicEditor.addInstance($(this).attr("id"))
      
  ).error ->
    adminAlert.removeClass()
    adminAlert.addClass("alert-message error");
    adminAlert.find('.message').html("We're sorry, an error has occured while fetching the template.")
    adminAlert.show()
    nicEditorDiv.hide()

siteTheme = ->
  notyetimplemented()

attachHandlersToAlertBlockButtons = ->
  adminPanel.find(".message").find(".btn").each ->
    functionName = $(this).attr("data-click")
    $(this).click eval(functionName) if functionName

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
    functionName = $(this).attr("data-click")
    $(this).click eval(functionName) if functionName

attachAdminAlertCloseHandler = ->
  adminAlert.find(".close").click ->
    closeAdminAlert()
    
attachExpandHandler = ->
  $("#expandAdminPanel").click(previewEnd)

initNicPanels = ->
  myNicEditor = new nicEditor()
  myNicEditor.setPanel("myNicPanel")
  nicEditorDiv = $("#myNicPanel")
  editables.each ->
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

