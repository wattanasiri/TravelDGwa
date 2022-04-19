const mongoose = require('mongoose')
const passportLocalMongoose = require('passport-local-mongoose');
const Schema = mongoose.Schema

const newSchema = new Schema({
    email : String,
    realname: { type: String, default: 'Name' },
    surname: { type: String, default: 'Surname' },
    role : { type: String, default: 'user' },
    phone : String,
    password : String,
    creditcardid : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Creditcards'
        }
    ],
    rolepartner: String,
    favorite : [
        {
            id : {
                type: mongoose.Schema.Types.ObjectId,
                refPath: 'favModel',
                
            },
            favModel : {
                type: String,
                required: true,
                enum: ['Hotel', 'Attraction', 'Restaurant']
            },
            _id: false,
    }
    ],
    booking : [
        {
            type: mongoose.Schema.Types.ObjectId,
        }
    ],
    img:{
        type: Buffer,
    },
    imgType: {
        type: String,
    },
    invoice: [
        {
            type: mongoose.Schema.Types.ObjectId,
        }
    ]
})

newSchema.plugin(passportLocalMongoose, {usernameField: 'email'});
module.exports = mongoose.model('User',newSchema)