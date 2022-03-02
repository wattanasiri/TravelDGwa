const express  = require('express');
const User = require('../models/user_model')
const passport = require('passport')
const router = express.Router()

router.post('/signin',(req,res,next) => {
    passport.authenticate('local', function(err, user, info) {
        if (err) return res.status(401).json(err)
        if (user) {
            // const token = user.generateJwt();
            return res.status(200).json({
                // "token": token
            });
        } else {
            console.log('user not found or wrong password')
            return res.status(401).json(info);
        }
    })(req, res, next)
})

router.get('/getuser',(req,res) => {
    User.find({},(err,foundUser) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundUser);
            return res.json(foundUser);
        }
    })
})

router.delete('deleteuser/:id',(req,res) => {
    User.findByIdAndDelete(req.params.id,(err,deleted) => {
        if(err){
            console.log(err);
        } else {
            console.log(deleted);
            console.log('deleted');
            res.status(200).json()
        }
    })
})

module.exports = router