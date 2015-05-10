MdConverter = require './convert-md'
SyncMdElephantView = require './sync-md-elephant-view'
{CompositeDisposable} = require 'atom'

module.exports = SyncMdElephant =
  syncMdElephantView: null
  modalPanel: null
  subscriptions: null
  mdConverter: null

  activate: (state) ->
    @syncMdElephantView = new SyncMdElephantView(state.syncMdElephantViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @syncMdElephantView.getElement(), visible: false)
    @mdConverter = new MdConverter
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sync-md-elephant:syncMd': => @syncMd()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @syncMdElephantView.destroy()

  serialize: ->
    syncMdElephantViewState: @syncMdElephantView.serialize()


  syncMd: ->

    html = @mdConverter.convert()
    console.log(html)

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
