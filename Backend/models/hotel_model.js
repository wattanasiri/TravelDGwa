const mongoose = require('mongoose')

var hotelSchema  = new mongoose.Schema({
    name : String,
    room : [
        {
            type : mongoose.Schema.Types.ObjectId,
            ref : 'Room'
        }
    ],
    image : String,
    location : String,
    price : Number,
    desc : String,
    star : Number,
    type : String,
    comments : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Comment'
        }
    ]
})

module.exports = mongoose.model('Hotel',hotelSchema)