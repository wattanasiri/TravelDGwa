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

function compareBookingDate(outDate) {
    let finishDate = Date.parse(outDate)
    const dateNow = Date.now()
    // console.log(dateNow)
    // console.log(finishDate)
    
    if (dateNow > finishDate) {
        return 'completed'
    } else {
        return 'soon'
    }
}

function compareBookingDateNoParsing(outDate) {
    const dateNow = Date.now()
    // console.log(dateNow)
    // console.log(outDate)
    if (dateNow > outDate) {
        return 'completed'
    } else {
        return 'soon'
    }
}

function convertDMYToYMD(date) {
    var parts = date.split("-");
    return parts[2] + '-' + parts[1] + '-' + parts[0]
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
                if (elem.canceled == true) {
                    newElem.status = 'canceled'
                } else {
                    var formattedTime = convertDMYToYMD(elem.checkOut)
                    newElem.status = compareBookingDate(formattedTime)
                }
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
                        if (elem.canceled == true) {
                            newElem.status = 'canceled'
                        } else {
                            var t = elem.starttime; // hh:mm
                            var ms = Number(t.split(':')[0]) * 60 * 60 * 1000 + Number(t.split(':')[1]) * 60 * 1000;
                            var sumTime = Date.parse(convertDMYToYMD(elem.startdate)) + ms
                            newElem.status = compareBookingDateNoParsing(sumTime)
                        }   
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
                                if (elem.canceled == true) {
                                    newElem.status = 'canceled'
                                } else {
                                    var t = elem.time_sentcar; // hh:mm
                                    var ms = Number(t.split(':')[0]) * 60 * 60 * 1000 + Number(t.split(':')[1]) * 60 * 1000;
                                    var sumTime = Date.parse(elem.date_sentcar) + ms
                                    newElem.status = compareBookingDateNoParsing(sumTime)
                                }   
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
                                        if (elem.canceled == true) {
                                            newElem.status = 'canceled'
                                        } else {
                                            var t = elem.time; // hh:mm
                                            var ms = Number(t.split(':')[0]) * 60 * 60 * 1000 + Number(t.split(':')[1]) * 60 * 1000;
                                            var sumTime = Date.parse(convertDMYToYMD(elem.day)) + ms
                                            newElem.status = compareBookingDateNoParsing(sumTime)
                                        }   
                                        bookingList.push(newElem)
                                    });
                                    console.log(bookingList)
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