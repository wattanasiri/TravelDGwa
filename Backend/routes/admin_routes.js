const express  = require('express');
const User = require('../models/user_model')
const passport = require('passport')
const router = express.Router()
const rentcarpartner = require('../models/rentcar_partner_model')

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
    User.find({role:'user'},(err,foundUser) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundUser);
            return res.json(foundUser);
        }
    })
})

router.get('/getuser/:id',(req,res) => {
    User.findById(req.params.id,(err,foundUser) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundUser);
            return res.json(foundUser);
        }
    })
})

router.delete('/deleteuser/:id',(req,res) => {
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

router.post('/promote/:id',(req,res) => {
    User.findByIdAndUpdate(req.params.id,{$set:{role:'admin'}},(err,foundUser) => {
        if(err){
            console.log(err)
        } else {
            return res.json(foundUser);
        }
    })
})

router.get('/getrentcarpartner',(req,res) => {
    rentcarpartner.find().populate('usernameID').exec((err,foundPartner) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundPartner);
            return res.json(foundPartner);
        }
    })
})

router.get('/getrentcarpartner/:id',(req,res) => {
    rentcarpartner.findById(req.params.id).populate('usernameID').exec((err,foundPartner) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundPartner);
            return res.json(foundPartner);
        }
    })
})

router.get('/getadmin',(req,res) => {
    User.find({role:'user'},(err,foundUser) => {
        if(err){
            console.log(err)
        } else{
            console.log(foundUser);
            return res.json(foundUser);
        }
    })
})

module.exports = router