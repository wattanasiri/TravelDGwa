const express  = require('express')
const middleware = require('../middleware')
const AccomTransaction = require('../models/accommodation_transaction')
const airporttransferreceipt = require('../models/airport_transfer_receipt_model')
const activityreceip = require('../models/activity_receipt_model')
const rentcarreceipt = require('../models/rentcar_transaction_model')
const User = require('../models/user_model')
const Room = require('../models/room_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText

const router = express.Router()

// get Model
function getModelType(type) {
    if (type == 'hotel') {
        return AccomTransaction
    } else if (type == 'transfer') {
        return airporttransferreceipt
    } else if (type == 'rentcar') {
        return rentcarreceipt
    } else if (type == 'activity') {
        return activityreceip
    }
    else {
        return 1;
    }
}

// get booking list
router.get('/' , middleware.isLoggedIn, (req,res) => {
    // the incoming token is 'Bearer #token#'
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    var bookingList = []
    var newElem
    // console.log(user)
    AccomTransaction.find({"usernameId" : user._id}, function (err, foundAccom) { // get Accom TODO: populate list with updated model.
        if (err) {
            console.log(err);
        }
        else {
            foundAccom.forEach((elem) => { 
                newElem = JSON.parse(JSON.stringify(elem))
                newElem.bookingType = 'accommodation'
                bookingList.push(newElem)
            });
            airporttransferreceipt.find({"usernameID" : user._id}, function (err, foundTransferRecipt) {  // get transfer receipt
                if (err) {
                    console.log(err);
                }
                else {
                    foundTransferRecipt.forEach((elem) => { 
                        newElem = JSON.parse(JSON.stringify(elem))
                        newElem.bookingType = 'transfer'
                        bookingList.push(newElem)
                    });
                    rentcarreceipt.find({"usernameID" : user._id}, function (err, foundRentcarRecipt) {  // get transfer receipt
                        if (err) {
                            console.log(err);
                        }
                        else {
                            foundRentcarRecipt.forEach((elem) => { 
                                newElem = JSON.parse(JSON.stringify(elem))
                                newElem.bookingType = 'rentcar'
                                bookingList.push(newElem)
                            });
                            activityreceip.find({"usernameID" : user._id}, function (err, foundActivityRecipt) {  // get transfer receipt
                                if (err) {
                                    console.log(err);
                                }
                                else {
                                    foundActivityRecipt.forEach((elem) => { 
                                        newElem = JSON.parse(JSON.stringify(elem))
                                        newElem.bookingType = 'activity'
                                        bookingList.push(newElem)
                                    });
                                    res.json({booking:bookingList})
                                }
                            });
                        }
                    });
                }
            });
        }
    });
})

// cancel booking
router.post('/cancel/:id' , middleware.isLoggedIn , (req,res) => {

    var Model = getModelType(req.body.type)
    if (Model === 1) return console.log('Invalid model type')

    Model.findByIdAndUpdate(req.params.id, { canceled: true }, function(err, updatedBooking) {
        if (err) return console.log(err)
        if (updatedBooking) {
            return res.status(200).json()
        } else {
            return res.status(404).json()
        }
    })
})

module.exports = router