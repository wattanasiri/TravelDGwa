const express  = require('express')
const lifestye = require('../models/map_model.js')
var mongoose = require('mongoose');
const ObjectId = require('mongodb').ObjectId; 

const router = express.Router()

router.post('/register_mapinfo',async (req,res) => { 
    console.log('register_mapinfo')
    console.log(req.body.usernameID)
    // const infouser = await User.findById(req.body.username)
    
    const infomap = await new lifestye({
        usernameID: mongoose.Types.ObjectId(req.body.usernameID),
        // price_extrapay: ,
        // document_require: ,
        // comment: ,
        Weather: req.body.weather,
        Adventure: req.body.adventure,
        Sea : req.body.sea,
        Confidence: req.body.confidence,
        BagPack: req.body.bagpack,
        Budget: req.body.budget,
        social: req.body.social,
    })
    infomap.save()
   
})

router.get('/:id' + '/infolifestyleuser', (req,res) => {
    console.log('getdetailuser')
    var id = req.params.id;
    console.log(id)
    lifestye.find({ "usernameID": id }).exec((err,foundinfo) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundinfo})
            console.log(foundinfo)
        }
    })
   
})


module.exports = router