const express  = require('express')
const middleware = require('../middleware')
const AccomTransaction = require('../models/accommodation_transaction')
const User = require('../models/user_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText


const router = express.Router()

router.get('/' , middleware.isLoggedIn, (req,res) => {
    // TODO: expand booking categories and limit to a specific user
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        var token = req.headers.authorization.split(' ')[1]
        var stringToken = JSON.parse(token)['token']
        var decodedtoken = jwt.decode(stringToken, secret)
        console.log(decodedtoken)
        AccomTransaction.find({}, function (err, foundBooking) {
            if (err) {
                console.log(err);
            }
            else {
                // console.log(foundBooking)
                res.json({booking:foundBooking})
            }
        });
    }
    else {
        return res.json({success: false})
    }

})

module.exports = router