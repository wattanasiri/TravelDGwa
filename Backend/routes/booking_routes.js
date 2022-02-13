const express  = require('express')
const middleware = require('../middleware')
const AccomTransaction = require('../models/accommodation_transaction')
const User = require('../models/user_model')

const router = express.Router()

router.get('/' , middleware.isLoggedIn, (req,res) => {
    // TODO: expand booking categories and limit to a specific user
    AccomTransaction.find({}, function (err, foundBooking) {
        if (err) {
            console.log(err);
        }
        else {
            console.log(foundBooking)
            res.json({booking:foundBooking})
        }
    });
})

module.exports = router