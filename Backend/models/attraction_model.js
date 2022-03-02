const mongoose = require('mongoose')

var attractionSchema  = new mongoose.Schema({
    name : String,
    image : String,
    location : String,
    price : Number,
    desc : String,
    star : Number,
    type : String,
    time : String,
    openday : String,
    image : [
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

module.exports = mongoose.model('Attraction',attractionSchema)