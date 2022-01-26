const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    NameCard : String,
    NumberCard: String,
    ValiDate : String,
    CVV : Number
})

module.exports = mongoose.model('Creditcards',newSchema)