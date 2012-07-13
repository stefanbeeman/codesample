mongoose = require('mongoose')

Task = new mongoose.Schema(
    text: String
    complete: Boolean
    due: Date
)

require('zappajs') 8080, ->
    mongoose.connect('mongodb://localhost/todo')
    @enable 'default layout'
    
    @get '/', ->
        @send 'Hello, World'
