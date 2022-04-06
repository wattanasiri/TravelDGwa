const mongoose = require('mongoose')
const Schema = mongoose.Schema

const airporttransferpartnerSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    username: String,
    car_brand: String,
    car_registration: String,
    phone: String,
    email: String,
    address: String,
    province: String,
    district: String,
    partner: {
        type: Boolean,
        default: false
    }
})

module.exports = mongoose.model('airporttransferpartner',airporttransferpartnerSchema )
