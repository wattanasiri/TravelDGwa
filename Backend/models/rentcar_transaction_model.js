const mongoose = require('mongoose')
const Schema = mongoose.Schema

const rentcarreceiptSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    partnername: String,
    car_name: String,
    car_license : String,
    date_sentcar: String,
    date_getcar: String,
    time_getcar: String,
    time_sentcar: String,
    location_getsentcar: String,
    detail_pricedate: String,
    detail_pricetime: String,
    detail_pricelocation: String,
    sum_detail_pricedate: Number,
    sum_detail_pricetime: Number,
    sum_detail_pricelocation: Number,
    total_price: String,
    canceled : { type: Boolean, default: false },
})

module.exports = mongoose.model('rentcarreceipt',rentcarreceiptSchema)