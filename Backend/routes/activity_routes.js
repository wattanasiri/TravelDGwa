const express  = require('express')
const activity = require('../models/activity_model')
const activityreceipt = require('../models/activity_receipt_model')
const jwt = require('jwt-simple')
const secret = require('..').SecretText

var mongoose = require('mongoose');

const router = express.Router()


router.get('/', (req,res) => {
    console.log('Hello')
    
    activity.find({star : "5"},(err , foundactivity) => {
        if(err){
            console.log(err)
        } else {

            res.json({foundactivity});
            console.log(foundactivity)
        }
    })
})

router.post('/activity_partner',async (req,res) => { 
    console.log('activity_partner')
    // console.log(req.body.usernameID)
    // const infouser = await User.findById(req.body.username)
    
    const activitypartner = await new activity({
        usernameID: mongoose.Types.ObjectId(decodedtoken._id),
        // price_extrapay: ,
        // document_require: ,
        // comment: ,
        name: req.body.name,
        location: req.body.location,
        price: req.body.price,
        star: req.body.star,
        detail: req.body.detail,
        open_day: req.body.opening_day,
        open_time: req.body.opening_time,
        image: req.body.image,
    })
    activitypartner.save()
    idactivitypartner = activitypartner._id.toString()
})

router.post('/update_activity',async (req,res) => { 
    console.log(idactivitypartner)
    console.log('update_activity')  
    // const infouser = await User.findById(req.body.username)
    const updatepartner = await activity.findById(idactivitypartner)
    console.log(updatepartner)
    for(i = 1;i<4;i++){
        updatepartner.hilight.push(req.body.hilight[i])
    }
    for(i = 1;i<6;i++){
        updatepartner.service.push(req.body.service[i])
    }
    // for(i = 1;i<4;i++){
    //     updatepartner.image.push(req.body.image[i])
    // }
    updatepartner.save()
})

router.get('/:names' + '/queryactivity' , (req,res) => {
    console.log('getactivity')
    var findname = req.params.names;
    console.log(findname)
    activity.findOne({ "name": findname }).exec((err,foundAcc) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundAcc})
            console.log(foundAcc)
        }
    })
   
})

router.post('/save_invoice',(req,res) => { 
    var token = req.headers.authorization.split(' ')[1]
    // we need to convert the string to JSON object first.
    var stringToken = JSON.parse(token)['token']
    var decodedtoken = jwt.decode(stringToken, secret)
    console.log('save invoice')
    console.log(req.body.username)
    const infoinvoice = new activityreceipt({
        usernameID: new mongoose.Types.ObjectId(decodedtoken._id),
        name: req.body.name,
        day : req.body.day,
        time : req.body.time,
        number: req.body.number,
        price: req.body.price,
        detail: req.body.detail,
        sum_price: req.body.sum_price,})
    infoinvoice.save()
    

})

module.exports = router