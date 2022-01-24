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
    location : String
})

module.exports = mongoose.model('Hotel',hotelSchema)