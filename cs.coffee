mongoose = require('mongoose')
async = require('async')

TaskSchema = new mongoose.Schema(
    text: String
    completed:
        type: Boolean
        default: false
    due: Date
)

mongoose.model('Task', TaskSchema)

require('zappajs') 8080, ->
    mongoose.connect('mongodb://localhost/todo')
    Task = mongoose.model('Task')
    
    @enable 'default layout'
    @use 'bodyParser'
    
    @stylus '/todo.css': '''
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
            -webkit-border-bottom-right-radius: 20px
            -webkit-border-bottom-left-radius: 20px
            -moz-border-radius-bottomright: 20px
            -moz-border-radius-bottomleft: 20px
            border-bottom-right-radius: 20px
            border-bottom-left-radius: 20px
            box-shadow: 0px 0px 4px 0px black
        
        .section_label
            height: 32px
            line-height: 32px
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
            padding: 8px
            -webkit-border-bottom-right-radius: 20px
            -webkit-border-bottom-left-radius: 20px
            -moz-border-radius-bottomright: 20px
            -moz-border-radius-bottomleft: 20px
            border-bottom-right-radius: 20px
            border-bottom-left-radius: 20px
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
            height: 32px
            margin-top: 8px
            margin-bottom: 8px
            line-height: 32px
            -webkit-border-radius: 20px
            -moz-border-radius: 20px
            border-radius: 20px
            padding-left: 8px
            padding-right: 8px
            background: rgb(246,248,249)
            background: -moz-linear-gradient(top, rgba(246,248,249,1) 0%, rgba(229,235,238,1) 50%, rgba(215,222,227,1) 51%, rgba(245,247,249,1) 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(246,248,249,1)), color-stop(50%,rgba(229,235,238,1)), color-stop(51%,rgba(215,222,227,1)), color-stop(100%,rgba(245,247,249,1)))
            background: -webkit-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: -o-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: -ms-linear-gradient(top, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
            background: linear-gradient(to bottom, rgba(246,248,249,1) 0%,rgba(229,235,238,1) 50%,rgba(215,222,227,1) 51%,rgba(245,247,249,1) 100%)
        
        .task:hover
            box-shadow: 0px 0px 4px 0px blue
        
        .task_text
            margin-left: 8px
        
        .soft
            color: grey
            font-style: italic
            
        #completed_empty, pending_empty
            margin-top: 8px
            margin-bottom: 8px
    '''
    
    @client '/todo.js': ->
        jQuery(document).ready ($) ->
            $('#input_create').on 'click', ->
                text = $('#input_text').val()
                due = $('#input_due').val()
                if text is ''
                    $('#input_text').focus()
                else if due is '' or isNaN( Date.parse(due) )
                    $('#input_due').focus()
                else
                    $.post '/create',
                        text: text
                        due: new Date(due)
                    , (response) ->
                        if response.error?
                            alert response.error
                        else
                            alert response.text
    
    @view 'main': ->
        @title = 'Todo List App'
        @stylesheet = '/todo'
        @scripts = ['/zappa/zappa', 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min', '/todo']
        
        render_tasks = (tasks) ->
            for task in tasks
                div class: 'task', ->
                    span class: 'task_text', -> task.text
                    span class: 'task_text soft', -> 'by ' + task.due.toDateString()
        
        div id: 'create', class: 'section', ->
            div class: 'section_label', -> 'Create a new task'
            div id: 'create_content', class: 'section_content', ->
                span class: 'input_label', -> 'Task:'
                input type: 'text', id: 'input_text', class: 'field'
                span class: 'input_label', -> 'Due Date:'
                input type: 'date', id: 'input_due', class: 'field'
                input type: 'button', id: 'input_create', value: 'Create', class: 'button'
        div id: 'pending', class: 'section', ->
            div class: 'section_label', -> 'Pending Tasks'
            div id: 'pending_content', class: 'section_content', ->
                if tasks.pending? and tasks.pending.length > 0
                    render_tasks(tasks.pending)
                else
                    div id: 'pending_empty', class: 'soft', -> 'You have no pending tasks'
        div id: 'completed', class: 'section', ->
            div class: 'section_label', -> 'Tasks Done'
            div id: 'completed_content', class: 'section_content', ->
                if tasks.completed? and tasks.completed.length > 0
                    render_tasks(tasks.completed)
                else
                    div id: 'completed_empty', class: 'soft', -> 'You have no completed tasks'
                
    @get '/': ->
        async.parallel(
            pending: (callback) ->
                Task.find({}).where('completed').equals(0).sort('due', 1).exec(callback)
            completed: (callback) ->
                Task.find({}).where('completed').equals(1).sort('due', 1).exec(callback)
        , (error, tasks) =>
            if error?
                console.log error
            @render main: {locals: {tasks: tasks}}
        )

    @post '/create': ->
        if not @body? or not @body.text? or not @body.due? or isNaN( Date.parse(@body.due) )
            @send {error: 'bad input'}
        else
            task = new Task(
                text: @body.text
                due: @body.due
            ).save()
            @send task
    
    @post '/complete': ->
        if not @body or not @body.task
            @send {error: 'bad input'}
        else
            Task.findById @body.task, (error, task) ->
                if error? or not task?
                    @send {error: 'no such task'}
                else
                    task.completed = true
                    task.save()
                    @send task
    
    @post '/delete': ->
        if not @body or not @body.task
            @send {error: 'bad input'}
        else
            Task.findById @body.task, (error, task) ->
                if error? or not task?
                    @send {error: 'no such task'}
                else
                    task.completed = true
                    task.remove()
                    @send task
