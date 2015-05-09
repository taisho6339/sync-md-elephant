SyncMdElephantView = require './sync-md-elephant-view'
{CompositeDisposable} = require 'atom'

module.exports = SyncMdElephant =
  syncMdElephantView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @syncMdElephantView = new SyncMdElephantView(state.syncMdElephantViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @syncMdElephantView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sync-md-elephant:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @syncMdElephantView.destroy()

  serialize: ->
    syncMdElephantViewState: @syncMdElephantView.serialize()

  toggle: ->
    console.log 'SyncMdElephant was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
