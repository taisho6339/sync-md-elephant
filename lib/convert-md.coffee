module.exports =
    class MdConverter

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
            html = "<style>" + css + "</style>" + html
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

        css = """
              .hljs {
                display: block;
                overflow-x: auto;
                padding: 0.5em;
                background: #000;
                color: #f8f8f8;
                -webkit-text-size-adjust: none;
              }

              .hljs-comment,
              .hljs-javadoc {
                color: #aeaeae;
                font-style: italic;
              }

              .hljs-keyword,
              .ruby .hljs-function .hljs-keyword,
              .hljs-request,
              .hljs-status,
              .nginx .hljs-title {
                color: #e28964;
              }

              .hljs-function .hljs-keyword,
              .hljs-sub .hljs-keyword,
              .method,
              .hljs-list .hljs-title {
                color: #99cf50;
              }

              .hljs-string,
              .hljs-tag .hljs-value,
              .hljs-cdata,
              .hljs-filter .hljs-argument,
              .hljs-attr_selector,
              .apache .hljs-cbracket,
              .hljs-date,
              .tex .hljs-command,
              .coffeescript .hljs-attribute,
              .hljs-name {
                color: #65b042;
              }

              .hljs-subst {
                color: #daefa3;
              }

              .hljs-regexp {
                color: #e9c062;
              }

              .hljs-title,
              .hljs-sub .hljs-identifier,
              .hljs-pi,
              .hljs-tag,
              .hljs-tag .hljs-keyword,
              .hljs-decorator,
              .hljs-shebang,
              .hljs-prompt {
                color: #89bdff;
              }

              .hljs-class .hljs-title,
              .hljs-type,
              .smalltalk .hljs-class,
              .hljs-javadoctag,
              .hljs-yardoctag,
              .hljs-phpdoc,
              .hljs-dartdoc {
                text-decoration: underline;
              }

              .hljs-symbol,
              .ruby .hljs-symbol .hljs-string,
              .hljs-number {
                color: #3387cc;
              }

              .hljs-params,
              .hljs-variable,
              .clojure .hljs-attribute {
                color: #3e87e3;
              }

              .css .hljs-tag,
              .hljs-rule .hljs-property,
              .hljs-pseudo,
              .tex .hljs-special {
                color: #cda869;
              }

              .css .hljs-class {
                color: #9b703f;
              }

              .hljs-rule .hljs-keyword {
                color: #c5af75;
              }

              .hljs-rule .hljs-value {
                color: #cf6a4c;
              }

              .css .hljs-id {
                color: #8b98ab;
              }

              .hljs-annotation,
              .apache .hljs-sqbracket,
              .nginx .hljs-built_in {
                color: #9b859d;
              }

              .hljs-preprocessor,
              .hljs-pragma {
                color: #8996a8;
              }

              .hljs-hexcolor,
              .css .hljs-value .hljs-number {
                color: #dd7b3b;
              }

              .css .hljs-function {
                color: #dad085;
              }

              .diff .hljs-header,
              .hljs-chunk,
              .tex .hljs-formula {
                background-color: #0e2231;
                color: #f8f8f8;
                font-style: italic;
              }

              .diff .hljs-change {
                background-color: #4a410d;
                color: #f8f8f8;
              }

              .hljs-addition {
                background-color: #253b22;
                color: #f8f8f8;
              }

              .hljs-deletion {
                background-color: #420e09;
                color: #f8f8f8;
              }

              .coffeescript .javascript,
              .javascript .xml,
              .tex .hljs-formula,
              .xml .javascript,
              .xml .vbscript,
              .xml .css,
              .xml .hljs-cdata {
                opacity: 0.5;
              }
              """
