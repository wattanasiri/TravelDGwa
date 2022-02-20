const express  = require('express')
const airporttransferpartner = require('../models/airport_transfer_partner_partner_model')
const airporttransferreceipt = require('../models/airport_transfer_receipt_model')
const User = require('../models/user_model')
var mongoose = require('mongoose');

const router = express.Router()

router.get('/', (req,res) => {
    console.log('Hello')
})

router.post('/register_shuttlepartner',(req,res) => { 
    console.log('register_shuttlepartner')
    const infopartner = new airporttransferpartner({username: req.body.username,
        display_name: req.body.display_name,
        car_brand: req.body.car_brand,
        car_registration: req.body.car_registration,
        phone: req.body.phone,
        email: req.body.email,})
    infopartner.save()

})

router.post('/save_invoice',(req,res) => { 
    
    console.log('save invoice')
    console.log(req.body.username)
    const infoinvoice = new airporttransferreceipt({
        usernameID: new mongoose.Types.ObjectId(req.body.username),
        typereserve: req.body.typereserve,
        typeshuttle : req.body.typeshuttle,
        yourlocation : req.body.yourlocation,
        destination: req.body.destination,
        startdate: req.body.startdate,
        starttime: req.body.starttime,
        sum_price: req.body.sum_price,})
    infoinvoice.save()

})



module.exports = router