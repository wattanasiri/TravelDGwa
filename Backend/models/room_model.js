const mongoose = require('mongoose')

var roomSchema  = new mongoose.Schema({
    hotelId : {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'Hotel'
    },
    room_name : String,
    image : String,
    price : Number
})

module.exports = mongoose.model('Room',roomSchema)