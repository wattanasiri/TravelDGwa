const express  = require('express')
const middleware = require('../middleware')
const AccomTransaction = require('../models/accommodation_transaction')
const airporttransferreceipt = require('../models/airport_transfer_receipt_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText


const router = express.Router()

// GET TOKEN
router.get('/' , middleware.isLoggedIn, (req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var decodedtoken = jwt.decode(stringToken, secret)
    var bookingList = []
    var newElem
    // console.log(decodedtoken._id)
    AccomTransaction.find({}, function (err, foundBooking) {
        if (err) {
            console.log(err);
        }
        else {
            foundBooking.forEach((elem) => {
                newElem = JSON.parse(JSON.stringify(elem));
                newElem.bookingType = 'accommodation'
                bookingList.push(newElem);
            });
            airporttransferreceipt.find({"usernameID" : decodedtoken._id}, function (err, foundTransferRecipt) {
                if (err) {
                    console.log(err);
                }
                else {
                    foundTransferRecipt.forEach((elem) => {
                        newElem = JSON.parse(JSON.stringify(elem));
                        newElem.bookingType = 'transferrecipt'
                        bookingList.push(newElem);
                    });
                    res.json({booking:bookingList})
                }
            });
        }
    });


})

module.exports = router