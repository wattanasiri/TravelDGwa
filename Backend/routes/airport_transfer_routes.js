const express  = require('express')
const airporttransferpartner = require('../models/airport_transfer_partner_model')
const airporttransferreceipt = require('../models/airport_transfer_receipt_model')
const User = require('../models/user_model')
var mongoose = require('mongoose');
const jwt = require('jwt-simple')
const secret = require('..').SecretText


const router = express.Router()

router.post('/register_shuttlepartner',(req,res) => { 
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var decodedtoken = jwt.decode(stringToken, secret)
    console.log('register_shuttlepartner')
    const infopartner = new airporttransferpartner({
        usernameID: mongoose.Types.ObjectId(decodedtoken._id),
        username: req.body.username,
        car_brand: req.body.car_brand,
        car_registration: req.body.car_registration,
        phone: req.body.phone,
        email: req.body.email,
        address: req.body.address,
        province: req.body.province,
        district: req.body.district})
    infopartner.save()

})

router.post('/save_invoice',(req,res) => { 
    
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var decodedtoken = jwt.decode(stringToken, secret)
    console.log('save invoice')
    console.log(req.body.username)
    const infoinvoice = new airporttransferreceipt({
        usernameID: new mongoose.Types.ObjectId(decodedtoken._id),
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