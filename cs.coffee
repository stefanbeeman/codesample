mongoose = require('mongoose')

Task = new mongoose.Schema(
    text: String
    complete: Boolean
    due: Date
)

require('zappajs') 8080, ->
    mongoose.connect('mongodb://localhost/todo')
    @enable 'default layout'
    @use errorHandler: {dumpExceptions: on}
    
    @stylus '/main.css': '''
        body
            margin: 0px
            font-size: 12px
            background: gray
        
        div
            position: relative
        
        .section
            width: 800px
            margin: auto
            margin-bottom: 24px
            margin-top: 8px
        
        .section_label
            height: 24px
            line-height: 24px
            text-align: center
            color: white
            font-weight: bold
            background: #45484d
            background: -moz-linear-gradient(top, #45484d 0%, #000000 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#45484d), color-stop(100%,#000000))
            background: -webkit-linear-gradient(top, #45484d 0%,#000000 100%)
            background: -o-linear-gradient(top, #45484d 0%,#000000 100%)
            background: -ms-linear-gradient(top, #45484d 0%,#000000 100%)
            background: linear-gradient(to bottom, #45484d 0%,#000000 100%)
            
        .section_content
            width: 784px
            padding-left: 8px
            padding-right: 8px
            padding-top: 16px
            padding-bottom: 16px
            -webkit-border-bottom-right-radius: 20px;
            -webkit-border-bottom-left-radius: 20px;
            -moz-border-radius-bottomright: 20px;
            -moz-border-radius-bottomleft: 20px;
            border-bottom-right-radius: 20px;
            border-bottom-left-radius: 20px;
            background: #eeeeee
            background: -moz-linear-gradient(top, #eeeeee 0%, #cccccc 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#eeeeee), color-stop(100%,#cccccc))
            background: -webkit-linear-gradient(top, #eeeeee 0%,#cccccc 100%)
            background: -o-linear-gradient(top, #eeeeee 0%,#cccccc 100%)
            background: -ms-linear-gradient(top, #eeeeee 0%,#cccccc 100%)
            background: linear-gradient(to bottom, #eeeeee 0%,#cccccc 100%)
        
        .input_label, .button
            display: inline-block
            margin-left: 8px
            margin-right: 8px
        
        #input_text, #input_due
            margin-right: 24px
        
        #input_text
            width: 400px
        
        #input_due
            width: 100px
        
        #input_create
            width: 100px
        
        .task
            background: rgb(246,248,249)
            background: -moz-linear-gradient(top, rgba(246,248,249,1) 0%, rgba(229,235,238,1) 50%, rgba(215,222,227,1) 51%, rgba(245,247,249,1) 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(246,248,249,1)), color-stop(50%,rgba(229,235,238,1)), color-stop(51%,rgba(215,222,227,1)), color-stop(100%,rgba(245,247,249,1)))
            background: -webkit-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: -o-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: -ms-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: linear-gradient(to bottom, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
    '''
    
    @view 'main': ->
        @title = 'Todo List App'
        @stylesheet = '/main'
        div id: 'create', class: 'section', ->
            div class: 'section_label', -> 'Create a new task'
            div id: 'create_content', class: 'section_content', ->
                span class: 'input_label', -> 'Task:'
                input type: 'text', id: 'input_text', class: 'field'
                span class: 'input_label', -> 'Due Date:'
                input type: 'text', id: 'input_due', class: 'field'
                input type: 'button', id: 'input_create', value: 'Create', class: 'button'
        div id: 'pending', class: 'section', ->
            div class: 'section_label', -> 'Pending Tasks'
            div id: 'pending_content', class: 'section_content', -> 'foobar'
        div id: 'completed', class: 'section', ->
            div class: 'section_label', -> 'Tasks Done'
            div id: 'completed_content', class: 'section_content', -> 'foobar'
        
    @get '/': ->
        @render 'main'
