module.exports =
    class ElephantManager

        client: null
        noteStore: null

        constructor: ->
            Client = require('evernote').Evernote.Client;
            Config = require('./config')

            @client = new Client({
                token: Config.TOKEN
                sandbox: true
            })

            console.log(Config.TOKEN)

            @noteStore = @client.getNoteStore()

        createContent: (content) ->
             nBody = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
             nBody += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
             nBody += "<en-note>" + content + "</en-note>"

             return nBody


        postNote: (title, content) ->

            Note = require('evernote').Evernote.Note;
            note = new Note()
            note.title = title
            note.content = @createContent(content)

            console.log(note.content)

            @noteStore.createNote(note,(err,note)->
                console.log("post note")
                console.log(err)
                console.log(note)
            )
