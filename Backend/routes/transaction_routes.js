const express  = require('express')
const AccomTransaction = require('../models/accommodation_transaction')

const router = express.Router()

router.post('/' , (req,res) => {
    var details = []
    
    AccomTransaction.create({   acc_name : req.body.acc_name,
    checkIn : req.body.checkIn,
    checkOut : req.body.checkOut,
    list : req.body.list} , (err,createdTransaction) => {
        if(err) {
            console.log(err)
            res.json(err)
        } else {
            res.json(createdTransaction)
        }
    })
})

module.exports = router