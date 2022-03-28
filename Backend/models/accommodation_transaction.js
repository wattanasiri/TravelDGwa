const mongoose = require('mongoose')

var accommTransactionSchema = mongoose.Schema({
    usernameId : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    acc_name : String,
    checkIn : String,
    checkOut : String,
<<<<<<< Updated upstream
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
=======
    room : String,
    numberOfRoom : Number,
    priceOfRoom : Number,
    numberOfDay : Number,
    totalPrice : Number
>>>>>>> Stashed changes
})

module.exports = mongoose.model('AccomTransaction', accommTransactionSchema)