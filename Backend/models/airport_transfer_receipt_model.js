const mongoose = require('mongoose')
const Schema = mongoose.Schema

const airporttransferreceiptSchema = new Schema({
    usernameID : {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
    typereserve: String,
    typeshuttle : String,
    yourlocation : String,
    destination: String,
    startdate: String,
    starttime: String,
    sum_price: String,
    
})

module.exports = mongoose.model('airporttransferreceipt',airporttransferreceiptSchema)