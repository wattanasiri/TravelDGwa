const express  = require('express')
const mapinfo = require('../models/map_model.js')
var mongoose = require('mongoose');
const ObjectId = require('mongodb').ObjectId; 

const router = express.Router()

router.post('/register_mapinfo',async (req,res) => { 
    console.log('register_mapinfo')
    console.log(req.body.usernameID)
    // const infouser = await User.findById(req.body.username)
    
    const infomap = await new mapinfo({
        usernameID: mongoose.Types.ObjectId(req.body.usernameid),
        // price_extrapay: ,
        // document_require: ,
        // comment: ,
        namepartner: req.body.partnername,
        phone: req.body.phone,
        email: req.body.email,
        opening_day: req.body.opening_day,
        opening_time: req.body.opening_time,
        Weather: req.body.partnername.weather,
        Adventure: req.body.partnername.adventure,
        Sea : req.body.partnername.sea,
        Confidence: req.body.partnername.confidence,
        BagPack: req.body.partnername.bagpack,
        Budget: req.body.partnername.budget,
        social: req.body.partnername.social,
        age: req.body.partnername.age,
    })
    infomap.save()
   
})

module.exports = router