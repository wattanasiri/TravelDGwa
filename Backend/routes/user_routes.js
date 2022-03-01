const express  = require('express')
const User = require('../models/user_model')
const shuttle_partner = require('../models/airport_transfer_partner_model')
const shuttle_invoice = require('../models/airport_transfer_receipt_model')
const passport = require('passport')

const router = express.Router()

router.get('/', (req,res) => {
    
    console.log('Hello')
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
                })
                console.log(user)
                User.register(user, req.body.password, function(err, user) {
                    if (err) {
                        console.log(err)
                        return res.status(401).json(err)
                    } 
                    passport.authenticate('local')(req, res, function() {
                        
                        res.json(user)
                        res.locals.currentUser = user
                        return res.status(200).json()
                    })
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
        
        
            console.log(res.locals.currentUser)
            // const token = user.generateJwt();
            return res.status(200).send(String(user._id));
        } else {
            console.log('user not found or wrong password')
            return res.status(401).json(info);
        }
    })(req, res, next)
})

//shuttle

module.exports = router