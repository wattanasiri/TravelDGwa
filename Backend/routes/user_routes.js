const express  = require('express')
const User = require('../models/user_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText
const shuttle_partner = require('../models/airport_transfer_partner_model')
const shuttle_invoice = require('../models/airport_transfer_receipt_model')
const passport = require('passport')
const middleware = require('../middleware')

const router = express.Router()

router.get('/', (req,res) => {
    
    console.log('Hello')
})

router.get('/getinfo', (req,res) => {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        var token = req.headers.authorization.split(' ')[1]
        var decodedtoken = jwt.decode(token, secret)
        return res.json({success: true, msg: 'Hello ' + decodedtoken.email})
    }
    else {
        return res.json({success: false, msg: 'No Headers'})
    }
})

router.post('/signup',(req,res) => {
    User.findOne({email:req.body.email,password:req.body.password} , (err,user) => {
        if(err){
            console.log(err)
            res.json(err)
        } else {
            if(user == null){
                const user = User({
                    email:req.body.email,
                    phone: req.body.phone,
                    realname:req.body.realname,
                    surname: req.body.surname,
                })
                console.log(user)
                User.register(user, req.body.password, function(err, user) {
                    if (err) {
                        console.log(err)
                        return res.status(401).json(err)
                    } 
                    console.log("Register successful.");
                        res.locals.currentUser = user
                        var token = jwt.encode(user, secret)

                        // aoy's branch only
                        // return res.status(200).send(String(user._id));
                        // Job's branch only for booking
                        return res.status(200).json({"token" : token})
                    })
            } else {
                return res.status(401).json({
                    'message' : 'email is not avaiable'
                })
            }

        }   
    })
})

router.post('/signin',(req,res,next) => {
    passport.authenticate('local', function(err, user, info) {
        if (err) return res.status(401).json(err)
        if (user) {
            req.login(user, function(err) {
                if (err) return next(err);
                console.log("Login successful.")
                var token = jwt.encode(user, secret)
                // console.log(res.locals.currentUser)

                // aoy's branch only
                // return res.status(200).send(String(user._id));
                // Job's branch only for booking
                return res.status(200).json({"token" : token})
            })
        } else {
            console.log('user not found or wrong password')
            return res.status(401).json(info);
        }
    })(req, res, next)
})

router.get('/favourite', middleware.isLoggedIn, (req,res) => {
    var user = middleware.getUser(req)

    User.findById(user._id).populate('favorite.id').exec(function(err, foundUser) {
        if (err) return console.log(err);
        if (foundUser) {
            var hotelList = []
            var attractionList = []
            var restaurantList = []
            var blogList = []
            foundUser.favorite.forEach(elem => {
                if (elem.favModel == 'Hotel') hotelList.push(elem.id)
                if (elem.favModel == 'Attraction') attractionList.push(elem.id)
                if (elem.favModel == 'Restaurant') restaurantList.push(elem.id)
                if (elem.favModel == 'Blog') blogList.push(elem.id)
            })
            console.log(hotelList)
            return res.status(200).json({hotelList:hotelList, attractionList:attractionList, restaurantList:restaurantList, blogList:blogList})
        } else {
            return console.log(err);
        }
    });
})

module.exports = router