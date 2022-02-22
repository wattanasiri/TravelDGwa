const express  = require('express')
const shuttle_partner = require('../models/shuttle_partner_model')
const shuttle_invoice = require('../models/shuttle_invoice_model')
const User = require('../models/user_model')

const router = express.Router()

router.get('/', (req,res) => {
    console.log('Hello')
})

router.post('/register_shuttlepartner',(req,res) => { 
    console.log('register_shuttlepartner')
    const infopartner = new shuttle_partner({username: req.body.username,
        display_name: req.body.display_name,
        car_brand: req.body.car_brand,
        car_registration: req.body.car_registration,
        phone: req.body.phone,
        email: req.body.email,})
    infopartner.save()

})

router.post('/save_invoice',(req,res) => { 
    console.log('save invoice')
    const infoinvoice = new shuttle_invoice({
        username: req.body.username,
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