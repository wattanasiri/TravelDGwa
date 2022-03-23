const mongoose = require('mongoose')
const passportLocalMongoose = require('passport-local-mongoose');
const Schema = mongoose.Schema

const newSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    Weather: Number,
    Adventure: Number,
    Sea : Number,
    Confidence: Number,
    BagPack: Number,
    Budget: Number,
    social: Number,
    age: Number,
    
})

module.exports = mongoose.model('map',newSchema)