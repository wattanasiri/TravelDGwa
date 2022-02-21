const express  = require('express')
const rentcarinfo = require('../models/rentcar_carinfo_model.js')
const rentcarpartner = require('../models/rentcar_partner_model.js')
const User = require('../models/user_model')
var mongoose = require('mongoose');


const router = express.Router()
var idinfopartner;

router.get('/', (req,res) => {
    console.log('Hello')
})

router.post('/register_rentcarpartner',async (req,res) => { 
    console.log('register_rentcarpartner')
    console.log(req.body.usernameID)
    // const infouser = await User.findById(req.body.username)
    
    const infopartner = await new rentcarpartner({
        usernameID: mongoose.Types.ObjectId(),
        // price_extrapay: ,
        // document_require: ,
        // comment: ,
        image: req.body.image,
        phone: req.body.phone,
        email: req.body.email,
    })
    infopartner.save()
    idinfopartner = infopartner._id.toString()
})
router.post('/update_register_rentcarpartner',async (req,res) => { 
    console.log('update_register_rentcarpartner')  
    // const infouser = await User.findById(req.body.username)
    const updatepartner = await rentcarpartner.findById(idinfopartner)
    for(i = 1;i<3;i++){
        updatepartner.document_require.push(req.body.document[i])
    }
    for(i = 1;i<4;i++){
        updatepartner.price_extrapay.push(req.body.price_extrapay[i])
    }
    for(i = 1;i<4;i++){
        updatepartner.time_extrapay.push(req.body.name_extrapay[i])
    }
    updatepartner.save()
   

})

router.post('/register_carinfo_rentcarpartner',async (req,res) => { 
    console.log('register_carinfo_rentcarpartner')  
    // const infouser = await User.findById(req.body.username)
    const carinfopartner = await new rentcarinfo({
        PartnerID: mongoose.Types.ObjectId(idinfopartner),
        car_name: req.body.carname,
        car_brand: req.body.carbrand,
        car_registration_year: req.body.year,
        car_nunber_sit: req.body.numsit,
        car_nunber_bigbag: req.body.bigbag,
        car_nunber_smallbag: req.body.smallbag,
        car_price_selfpick : req.body.selfpick,
        car_price_sentcar: req.body.sentcar,
    })
   
    carinfopartner.save()
    console.log(idinfopartner)
    const updatepartner2 = await rentcarpartner.findById(idinfopartner)
    console.log(updatepartner2)
    updatepartner2.carinfoID.push(carinfopartner._id)
    updatepartner2.save()

})

module.exports = router