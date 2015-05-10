module.exports =
    class MdConverter

        convertToHtml: (text) ->
            marked = require 'marked'
            html = marked(text)
            html = html.replace(/(id=\".*\")/g,"")
            return html

        getTitle: ->
            @editor = atom.workspace.getActiveTextEditor()
            return @editor.getTitle()

        convert: ->
            @editor = atom.workspace.getActiveTextEditor()
            text = @editor.getText()
            html = @convertToHtml(text)
            return html
