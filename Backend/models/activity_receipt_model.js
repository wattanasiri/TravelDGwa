const mongoose = require('mongoose')
const Schema = mongoose.Schema

const activityreceiptSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    name: String,
    day : String,
    time : String,
    number: Number,
    price: Number,
    sum_price: Number,
    detail :String,
    canceled : { type: Boolean, default: false },
})

module.exports = mongoose.model('activityreceip',activityreceiptSchema)