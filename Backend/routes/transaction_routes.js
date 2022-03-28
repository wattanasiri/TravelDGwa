const express  = require('express')
const AccomTransaction = require('../models/accommodation_transaction')

const router = express.Router()

router.post('/' , (req,res) => {
    var details = []
    AccomTransaction.create({
    usernameId : req.body.usernameId,
    acc_name : req.body.acc_name,
    checkIn : req.body.checkIn,
    checkOut : req.body.checkOut,
    room : req.body.room,
    numberOfRoom : req.body.numberOfRoom,
    priceOfRoom : req.body.priceOfRoom,
    totalPrice: req.body.totalPrice} , (err,createdTransaction) => {
        if(err) {
            console.log(err)
            res.json(err)
        } else {
            res.json(createdTransaction)
        }
    })
})

module.exports = router