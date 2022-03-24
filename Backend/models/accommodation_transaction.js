const mongoose = require('mongoose')

var accommTransactionSchema = mongoose.Schema({
    user : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    acc_name : String,
    checkIn : String,
    checkOut : String,
    list : [
        {
            roomId : {
              type : mongoose.Schema.Types.ObjectId,
              ref : 'Room'  
            },
            numberOfRoom : Number,
            room_name : String,
            price : Number
        }
    ],
    canceled : { type: Boolean, default: false },
})

module.exports = mongoose.model('AccomTransaction', accommTransactionSchema)