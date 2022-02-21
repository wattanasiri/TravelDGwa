const mongoose = require('mongoose')
const Schema = mongoose.Schema

const rentcarcarinfoSchema = new Schema({
    
    PartnerID: {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'airporttransferpartner'
    },
    car_name: String,
    car_brand: String,
    car_registration_year: String,
    car_nunber_sit: String,
    car_nunber_bigbag: String,
    car_nunber_smallbag: String,
    car_image: [
        {
            type:String
        }
    ],
    car_service: [
        {
            type:String
        }
    ],
    car_country: String,
    car_price_selfpick : Number,
    car_price_sentcar: Number,
    
    
    
})

module.exports = mongoose.model('rentcarcarinfo',rentcarcarinfoSchema )