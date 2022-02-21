const mongoose = require('mongoose')
const Schema = mongoose.Schema

const rentcarpartnerSchema = new Schema({
    
    usernameID: {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    namepartner: String,
    date_open: String,
    time_open: String,
    time_extrapay: [
        {
            type: String
        }
    ],
    price_extrapay: [
        {
            type: String
        }
    ],
    document_require: [
        {
            type: String
        }
    ],
    comment:[
        {
            type : mongoose.Schema.Types.ObjectId,
            ref : 'comment'   
        }
    ],
    carinfoID:[
        {
            type : mongoose.Schema.Types.ObjectId,
            ref : 'comment'   
        }
    ],
    image: String,
    phone : String,
    email: String,
    
    
})

module.exports = mongoose.model('rentcarpartner',rentcarpartnerSchema )