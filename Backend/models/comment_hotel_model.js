const mongoose = require('mongoose')

var commentSchema = mongoose.Schema({
    author : {
        id : {
            type : mongoose.Schema.Types.ObjectId,
            ref : 'User'
        },
        username : String,
        image:String
    },
    text: String,
    date: String,
    time: String,
    rating : Number
})

module.exports = mongoose.model('Comment', commentSchema)