const mongoose = require('mongoose')

var activitySchema  = new mongoose.Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    name : String,
    image :  [
        {
            type: String,
        }
    ],
    open_day : String,
    open_time : String,
    location : String,
    price : Number,
    star : Number,
    detail :String,
    service :  [
        {
            type: String,
        }
    ],
    hilight : [
        {
            type: String,
        }
    ],
    comments : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Comment'
        }
    ]
})

module.exports = mongoose.model('Activity',activitySchema)