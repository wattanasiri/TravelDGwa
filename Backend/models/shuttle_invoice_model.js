const mongoose = require('mongoose')
const Schema = mongoose.Schema

const shuttle_invoiceSchema = new Schema({
    username: String,
    typereserve: String,
    typeshuttle : String,
    yourlocation : String,
    destination: String,
    startdate: String,
    starttime: String,
    sum_price: String,
    
})

module.exports = mongoose.model('shuttle_invoice',shuttle_invoiceSchema)