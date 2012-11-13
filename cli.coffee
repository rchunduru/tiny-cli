mainmenu = [
    name:"showname"
    description: "contains commands about item1"
    help: "contains commands about item1"
,
    name:"showid"
    description: "contains commands about item2"
    help: "contains commands about item2"

]

name = [
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



id = [
    name:"testid"
    description: "Test function"
    help: "testhelp"
,
    name:"printid"
    description: "prints name"
    help: "testhelp"
,
    name: "showmenu"
    description: "show the menu items"
    help: "No arguments required"
]

currentmenu= mainmenu
defaultoptions = ".exit .quit .q .mainmenu "
options= defaultoptions

testname = ->
    console.log 'testname'
testfn = ->
    console.log 'testfn'

testhelp = ->
    console.log 'in the function testhelp'

printname = (arr) ->
    console.log 'in the function printname'
    console.log arr

printid= ->
    console.log 'in the funciton printid'


testid = ->
    console.log 'in the funciton testid'


showid= ->
    menuoptions = fillcompleter id
    currentmenu = id
    options = defaultoptions + menuoptions
    showmenu()

showname = ->
    menuoptions = fillcompleter name
    currentmenu = name
    options = defaultoptions + menuoptions
    showmenu()


showmenu = ->
    result = ""
    for index in currentmenu
        result += "#{index.name}\t\t#{index.description}\n"
        #console.log index
   
    console.log result


fillcompleter = (imenu) ->
    menuoptions = ""
    for index in imenu
        menuoptions += "#{index.name} "
    return menuoptions

options += fillcompleter(mainmenu)
autocomplete = (line) ->
    completions = options.split(" ")
    hits = completions.filter((c) ->
        c.indexOf(line) is 0
    )
    # show all completions if none found
    [(if hits.length then hits else completions), line]


getMenuItem = (cmd, imenu) ->
    for index in imenu
        if index.name == cmd
            return index

readline = require 'readline'

rl = readline.createInterface process.stdin, process.stdout, autocomplete
rl.setPrompt 'CLI>'
rl.prompt()

rl.on('line', (line) ->
    cmd = line.trim()
    arr = cmd.split(" ")
    cmd = arr[0]
    item = getMenuItem arr[0], currentmenu
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
            when 'mainmenu'
                currentmenu = mainmenu
                options = fillcompleter mainmenu
                options += defaultoptions
            else
                console.log 'unsupported command'

    rl.prompt()
).on 'close', ->
    console.log 'End of CLI'
    process.exit 0



        
