module.exports =
    class MdConverter
        constructor: ->
            @editor = atom.workspace.getActiveTextEditor()

        convertToHtml: (text) ->
            marked = require 'marked'
            html = marked(text)
            return html

        getTitle: ->
            return @editor.getTitle()

        convert: ->
            text = @editor.getText()
            html = @convertToHtml(text)
            return html
