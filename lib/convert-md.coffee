module.exports =
    class MdConverter

        css: null

        constructor: ->
            fs = require 'fs'
            @css = fs.readFileSync('/Users/hiroberry/github/sync-md-elephant/styles/default.css', 'utf8')

        convertToHtml: (text) ->
            marked = require 'marked'
            inliner = require 'inline-css'

            marked.setOptions({
                "highlight" : (code) ->
                    require('highlight.js').highlightAuto(code).value
                })
            html = marked(text)
            html = html.replace(/(id=\".*\")/g, "")
            # console.log(html)
            html = "<style>" + @css + "</style>" + html
            inliner(html,
                {
                    applyStyleTags : true,
                    applyLinkTags : true,
                    removeStyleTags : true,
                    removeLinkTags : true,
                    url : "filePath"
                },
                (err, res) ->
                    console.log(res)
                    html = res
                    html = html.replace(/(class=\"[^\s]*\")/g, "")
            )
            return html

        getTitle: ->
            @editor = atom.workspace.getActiveTextEditor()
            return @editor.getTitle()

        convert: ->
            @editor = atom.workspace.getActiveTextEditor()
            text = @editor.getText()
            html = @convertToHtml(text)
            return html
