const mongoose = require('mongoose')
const passportLocalMongoose = require('passport-local-mongoose');
const Schema = mongoose.Schema

const newSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    status: String,
    nametrip: String,
    alltime: String,
    location: [
        {
            type: String
        }
    ],
    starttime: [
        {
            type: String
        }
    ],
    endtime: [
        {
            type: String
        }
    ],
    
})

module.exports = mongoose.model('trip',newSchema)