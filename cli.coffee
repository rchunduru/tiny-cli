menu = [
    name:"testname"
    description: "Test function"
    help: "testhelp"
,
    name:"printname"
    description: "prints name"
    help: "testhelp"
,
    name: "showmenu"
    description: "show the menu items"
    help: "No arguments required"
]

testname = ->
    console.log 'testname'
testfn = ->
    console.log 'testfn'

testhelp = ->
    console.log 'in the function testhelp'

printname = (arr) ->
    console.log 'in the function printname'
    console.log arr

showmenu = ->
    result = ""
    for index in menu
        result += "#{index.name}\t#{index.description}\n"
        #console.log index
   
    console.log result

defaultoptions = ".exit .quit .q"
options= ""

fillcompleter = ->
    for index in menu
        options += "#{index.name} " 
    options += defaultoptions
    console.log 'options: ' + options

autocomplete = (line) ->
    completions = options.split(" ")
    hits = completions.filter((c) ->
        c.indexOf(line) is 0
    )
    # show all completions if none found
    [(if hits.length then hits else completions), line]


getMenuItem = (cmd) ->
    for index in menu
        if index.name == cmd
            return index

readline = require 'readline'
fillcompleter()
rl = readline.createInterface process.stdin, process.stdout, autocomplete
rl.setPrompt 'CLI>'
rl.prompt()

rl.on('line', (line) ->
    cmd = line.trim()
    arr = cmd.split(" ")
    cmd = arr[0]
    item = getMenuItem (arr[0])
    if item
        switch (arr[1])
            when '?', 'help'
                fncall = "#{item.help}()"
                eval fncall
            else
                fncall = cmd + "('"
                for i in arr
                    fncall += " #{i}" unless i==cmd
                fncall += "');"
                eval fncall
    else
        switch (cmd)
            when 'quit', 'q' , 'exit'
                process.exit 0

    rl.prompt()
).on 'close', ->
    console.log 'End of CLI'
    process.exit 0



        
