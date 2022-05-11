const express  = require('express')
const lifestye = require('../models/map_model.js')
const trip = require('../models/trip_model.js')
var mongoose = require('mongoose');
const ObjectId = require('mongodb').ObjectId; 
const secret = require('..').SecretText
const jwt = require('jwt-simple')
const router = express.Router()
var infotrip;
var updatecarinfotrip;

router.get('/getuserid', (req,res) => {
    console.log('getuserid')
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    console.log(user._id)
    res.json(user._id)
    // lifestye.find({ "usernameID": id }).exec((err,foundinfo) => {
    //     if(err){
    //         console.log(err)
    //     } else {
    //         res.json({foundinfo})
    //         console.log(foundinfo)
    //     }
    // })
   
})

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

router.get('/:id' + '/querydatamap', (req,res) => {
    console.log('querydatamap')
    var id = req.params.id;
    console.log(id)
    trip.find({ "usernameID": id }).exec((err,foundinfo) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundinfo})
            console.log(foundinfo)
        }
    })
   
})

router.get('/:id' + '/querydatamapandupdatstatus',async (req,res) => {
    console.log('updatestatus')
    console.log(updatecarinfotrip._id)
    var result = await trip.updateOne({_id:updatecarinfotrip._id},{$set:{status:'success'}})
    console.log('querydatamap')
    var id = req.params.id;
    console.log(id)
    trip.find({ "usernameID": id }).exec((err,foundinfo) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundinfo})
            console.log(foundinfo)
        }
    })
   
})

router.get('/:id' + '/querydataandupdatstatus' + '/:idtrip',async (req,res) => {
    console.log('updatestatus')
    console.log(req.params.idtrip)
    var result = await trip.updateOne({_id:req.params.idtrip},{$set:{status:'success'}})
    console.log('querydatamap')
    var id = req.params.id;
    console.log(id)
    trip.find({ "usernameID": id }).exec((err,foundinfo) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundinfo})
            console.log(foundinfo)
        }
    })
   
})

router.post('/savetrip',async (req,res) => {
    console.log('savetrip')
    console.log(req.body.usernameID)
    // const infouser = await User.findById(req.body.username)
    
    infotrip = await new trip({
        usernameID: mongoose.Types.ObjectId(req.body.usernameID),
        // price_extrapay: ,
        // document_require: ,
        // comment: ,
        status: 'unsuccess',
        nametrip: req.body.title,
    })
    await infotrip.save()
   
})

router.post('/updatetrip',async (req,res) => { 
    console.log('savetrip2')  
    console.log(req.body)  
  
    updatecarinfotrip = await new trip({
        usernameID: mongoose.Types.ObjectId(req.body.usernameID[1]),
        status: 'unsuccess',
        nametrip: req.body.title[1],
        alltime: req.body.alltime[0]
    });
    
    console.log(updatecarinfotrip)
    console.log(req.body.location.length)
    for(i = 1;i<req.body.location.length;i++){
        updatecarinfotrip.location.push(req.body.location[i])
    }
    for(i = 1;i<req.body.location.length;i++){
        updatecarinfotrip.starttime.push(req.body.starttime[i])
    }
    for(i = 1;i<req.body.location.length;i++){
        updatecarinfotrip.endtime.push(req.body.endtime[i])
    }
    
    updatecarinfotrip.save()
})

router.get('/updatestatus',async  (req,res) => {
    console.log('updatestatus')
    console.log(updatecarinfotrip._id)
    var result2 = await trip.updateOne({_id:updatecarinfotrip._id},{$set:{status:'success'}})
 
   
})




module.exports = router