const express  = require('express')
const middleware = require('../middleware')
const AccomTransaction = require('../models/accommodation_transaction')
const airporttransferreceipt = require('../models/airport_transfer_receipt_model')
const activityreceip = require('../models/activity_receipt_model')
const rentcarreceipt = require('../models/rentcar_transaction_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText


const router = express.Router()

// GET TOKEN
router.get('/' , middleware.isLoggedIn, (req,res) => {
    // the incoming token is 'Bearer #token#'
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    var bookingList = []
    var newElem
    // console.log(user)
    AccomTransaction.find({}, function (err, foundAccom) { // get Accom
        if (err) {
            console.log(err);
        }
        else {
            foundAccom.forEach((elem) => { 
                newElem = JSON.parse(JSON.stringify(elem));
                newElem.bookingType = 'accommodation'
                bookingList.push(newElem);
            });
            airporttransferreceipt.find({"usernameID" : user._id}, function (err, foundTransferRecipt) {  // get transfer receipt
                if (err) {
                    console.log(err);
                }
                else {
                    foundTransferRecipt.forEach((elem) => { 
                        newElem = JSON.parse(JSON.stringify(elem));
                        newElem.bookingType = 'transfer'
                        bookingList.push(newElem);
                    });
                    res.json({booking:bookingList})
                }
            });
        }
    });


})

module.exports = router