const mongoose = require('mongoose')
const Schema = mongoose.Schema

const rentcarcarinfoSchema = new Schema({
    
    PartnerID: {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'rentcarpartner'
    },
    nameOfUser: String,
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
    car_locationpickup: [
        {
            type:String
        }
    ],
    car_pricelocationpickup: [
        {
            type:Number
        }
    ],
    car_partnername: String,
    car_location: String,
    car_country: String,
    car_price: Number,
    car_price_minute: Number,
    car_license: String,
    car_rating: Number, 
    car_counting: Number
    
    
    
})

module.exports = mongoose.model('rentcarcarinfo',rentcarcarinfoSchema )