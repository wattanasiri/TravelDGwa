const mongoose = require('mongoose')
const Schema = mongoose.Schema

const airporttransferpartnerSchema = new Schema({
    username: String,
    display_name: String,
    car_brand: String,
    car_registration: String,
    phone: String,
    email: String,

})

module.exports = mongoose.model('airporttransferpartner',airporttransferpartnerSchema )
