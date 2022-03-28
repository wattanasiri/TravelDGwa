const mongoose = require('mongoose')

var accommTransactionSchema = mongoose.Schema({
    usernameId : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    acc_name : String,
    checkIn : String,
    checkOut : String,
    room : String,
    numberOfRoom : Number,
    priceOfRoom : Number,
    numberOfDay : Number,
    totalPrice : Number,
    canceled : { type: Boolean, default: false },
})

module.exports = mongoose.model('AccomTransaction', accommTransactionSchema)