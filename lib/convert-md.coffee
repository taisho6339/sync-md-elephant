module.exports =
    class MdConverter
        constructor: ->
            @editor = atom.workspace.getActiveTextEditor()

        convertToHtml: (text) ->
            marked = require 'marked'
            html = marked(text)
            return html

        convert: ->
            text = @editor.getText()
            html = @convertToHtml(text)
            return html
