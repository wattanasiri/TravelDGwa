const mongoose = require('mongoose')

var activitySchema  = new mongoose.Schema({
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
    service :  [
        {
            type: String,
        }
    ],
    hilight : [
        {
            type: String,
        }
    ]
})

module.exports = mongoose.model('Activity',activitySchema)