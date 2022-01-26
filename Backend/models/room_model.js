const mongoose = require('mongoose')

var roomSchema  = new mongoose.Schema({
    // hotelId : {
    //     type : mongoose.Schema.Types.ObjectId,
    //     ref : 'Hotel'
    // },
    room_name : String,
    image : [String],
    price : Number,
    area : Number,
    person_per_room : Number,
    facilities : [
        {
            icon : String,
            desc : String
        }
    ]
})

module.exports = mongoose.model('Room',roomSchema)