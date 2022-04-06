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
    type: String,
    text: String,
    date: String,
    time: String,
    rating : { type: Number, default: 3 },
    like: { type: Number, default: 0 },
    dislike: { type: Number, default: 0 },
    likedby : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
        }
    ],
    dislikedby : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
        }
    ]
})

module.exports = mongoose.model('Comment', commentSchema)