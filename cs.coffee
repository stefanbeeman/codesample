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
    @use 'static', 'bodyParser'
    
    @stylus '/todo.css': '''
        body
            margin: 0px
            font-size: 12px
            background: gray
            cursor: default
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        
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
        
        .button
            cursor: pointer
            
        #input_text, #input_due
            margin-right: 24px
        
        #input_text
            width: 400px
        
        #input_due
            width: 100px
        
        #input_create
            width: 100px
        
        .input_complete
            position: absolute
            right: 16px
            top: 4px
        
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
        
        .overdue, .completed
            color: white
        
        .overdue .soft, .completed .soft
            color: white !important
        
        .overdue
            font-weight: bold
            background: rgb(239,197,202)
            background: -moz-linear-gradient(top, rgba(239,197,202,1) 0%, rgba(210,75,90,1) 50%, rgba(186,39,55,1) 51%, rgba(241,142,153,1) 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(239,197,202,1)), color-stop(50%,rgba(210,75,90,1)), color-stop(51%,rgba(186,39,55,1)), color-stop(100%,rgba(241,142,153,1)))
            background: -webkit-linear-gradient(top, rgba(239,197,202,1) 0%,rgba(210,75,90,1) 50%,rgba(186,39,55,1) 51%,rgba(241,142,153,1) 100%)
            background: -o-linear-gradient(top, rgba(239,197,202,1) 0%,rgba(210,75,90,1) 50%,rgba(186,39,55,1) 51%,rgba(241,142,153,1) 100%)
            background: -ms-linear-gradient(top, rgba(239,197,202,1) 0%,rgba(210,75,90,1) 50%,rgba(186,39,55,1) 51%,rgba(241,142,153,1) 100%)
            background: linear-gradient(to bottom, rgba(239,197,202,1) 0%,rgba(210,75,90,1) 50%,rgba(186,39,55,1) 51%,rgba(241,142,153,1) 100%)
                
        .completed
            background: rgb(191,210,85)
            background: -moz-linear-gradient(top,  rgba(191,210,85,1) 0%, rgba(142,185,42,1) 50%, rgba(114,170,0,1) 51%, rgba(158,203,45,1) 100%)
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(191,210,85,1)), color-stop(50%,rgba(142,185,42,1)), color-stop(51%,rgba(114,170,0,1)), color-stop(100%,rgba(158,203,45,1)))
            background: -webkit-linear-gradient(top,  rgba(191,210,85,1) 0%,rgba(142,185,42,1) 50%,rgba(114,170,0,1) 51%,rgba(158,203,45,1) 100%)
            background: -o-linear-gradient(top,  rgba(191,210,85,1) 0%,rgba(142,185,42,1) 50%,rgba(114,170,0,1) 51%,rgba(158,203,45,1) 100%)
            background: -ms-linear-gradient(top,  rgba(191,210,85,1) 0%,rgba(142,185,42,1) 50%,rgba(114,170,0,1) 51%,rgba(158,203,45,1) 100%)
            background: linear-gradient(to bottom,  rgba(191,210,85,1) 0%,rgba(142,185,42,1) 50%,rgba(114,170,0,1) 51%,rgba(158,203,45,1) 100%)

        #completed_empty, #pending_empty
            margin-top: 8px
            margin-bottom: 8px
            text-align: center
    '''
    
    @client '/todo.js': ->
        jQuery.fn.insertTask = (task) ->
            task = $(task)
            task_due = parseInt( task.attr('data-due') )
            placed = false
            this.children().each (i, childNode) ->
                child = $(childNode)
                child_due = parseInt( child.attr('data-due') )
                if child_due > task_due and not placed
                    child.before(task)
                    placed = true
            if not placed
                this.append(task)

        jQuery(document).ready ($) ->
            $('#input_create').on 'click', ->
                text = $('#input_text').val()
                due = $('#input_due').val()
                if text is ''
                    alert 'Please describe your task.'
                    $('#input_text').focus()
                else if due is '' or isNaN( Date.parse(due) )
                    alert 'Please add a date.'
                    $('#input_due').focus()
                else
                    $('#input_due').val('')
                    $('#input_text').val('')
                    $.post '/create',
                        text: text
                        due: due
                    , (res) ->
                        if res is 'error'
                            alert 'Something went wrong creating your task. Tell me about it on GitHub.'
                        else
                            $('#pending_empty').hide()
                            $('#pending_content').insertTask(res)
            
            $('#pending_content').on 'click', '.input_complete', ->
                task = $(this).parent().attr('id')
                $.post '/complete',
                    task: task
                , (res) ->
                    if res is 'error'
                        alert 'Something went wrong completing your task. Tell me about it on GitHub.'
                    else
                        completed = $('#' + res).removeClass('overdue').addClass('completed').detach()
                        if $('#pending_content').children('.task').length < 1
                            $('#pending_empty').show()
                        completed.children('input').remove()
                        $('#completed_empty').hide()
                        $('#completed_content').insertTask(completed)
            
            $('#input_due').dateinput()
                
    @view 'main': ->
        @title = 'Todo List App'
        @stylesheets = ['css/calendar', '/todo']
        @scripts = ['/zappa/zappa', 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min', 'http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min', '/todo']
        
        render_tasks = (tasks) ->
            for task in tasks
                if task.completed
                    classes = 'task completed'
                else if task.due < Date.now()
                    classes = 'task overdue'
                else
                    classes = 'task'
                div id: String(task.id), class: classes, 'data-due': String( task.due.valueOf() ),  ->
                    span class: 'task_text', -> task.text
                    span class: 'task_text soft', -> 'by ' + task.due.toDateString()
                    if not task.completed
                        input type: 'button', class: 'button input_complete', value: 'Complete'
        
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
            div id: 'pending_content', class: 'section_content', ->
                if tasks.pending? and tasks.pending.length > 0
                    render_tasks(tasks.pending)
                    div id: 'pending_empty', class: 'soft', style: 'display: none;', -> 'You have no pending tasks'
                else
                    div id: 'pending_empty', class: 'soft', -> 'You have no pending tasks'
        div id: 'completed', class: 'section', ->
            div class: 'section_label', -> 'Tasks Done'
            div id: 'completed_content', class: 'section_content', ->
                if tasks.completed? and tasks.completed.length > 0
                    render_tasks(tasks.completed)
                    div id: 'completed_empty', class: 'soft', style: 'display: none;', -> 'You have no completed tasks'
                else
                    div id: 'completed_empty', class: 'soft', -> 'You have no completed tasks'
    
    @view 'new': ->
        if task.completed
            classes = 'task completed'
        else if task.due < Date.now()
            classes = 'task overdue'
        else
            classes = 'task'
        div id: String(task.id), class: classes, 'data-due': String( task.due.valueOf() ),  ->
            span class: 'task_text', -> task.text
            span class: 'task_text soft', -> 'by ' + task.due.toDateString()
            if not task.completed
                input type: 'button', class: 'input_complete', value: 'Complete'
        
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
            @send 'error'
        else
            task = new Task(
                text: @body.text
                due: new Date(@body.due)
            )
            task.save()
            @render new: {locals: {task: task}, layout: false}
    
    @post '/complete': ->
        if not @body or not @body.task
            @send 'error'
        else
            Task.findById @body.task, (error, task) =>
                if error? or not task?
                    @send 'error'
                else
                    task.completed = true
                    task.save()
                    @send String(task.id)
    
    @post '/delete': ->
        if not @body or not @body.task
            @send 'error'
        else
            Task.findById @body.task, (error, task) =>
                if error? or not task?
                    @send 'error'
                else
                    task.completed = true
                    task.remove()
                    @send String(task.id)

    @get '/flush': ->
        Task.find().remove()
        @send 'done'
