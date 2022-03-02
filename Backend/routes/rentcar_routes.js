const express  = require('express')
const rentcarinfo = require('../models/rentcar_carinfo_model.js')
const rentcarpartner = require('../models/rentcar_partner_model.js')
const User = require('../models/user_model')
const rentcarreceipt = require('../models/rentcar_transaction_model')
var mongoose = require('mongoose');
const { db } = require('../models/rentcar_transaction_model')
const ObjectId = require('mongodb').ObjectId; 


const router = express.Router()
var idinfopartner;
var idinfocar;
var updatepartner2;
var idreceipt;

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
        namepartner: req.body.partnername,
        phone: req.body.phone,
        email: req.body.email,
        opening_day: req.body.opening_day,
        opening_time: req.body.opening_time,
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
        car_location: req.body.location,
        car_country: req.body.country,
        car_price_minute: req.body.price_minute,
        car_price: req.body.price,
        car_partnername: req.body.partnername,
        car_license: req.body.license,
        car_rating: req.body.rating,
    })
   
    carinfopartner.save()
    idinfocar = carinfopartner._id.toString()
    console.log(idinfopartner)
    updatepartner2 = await rentcarpartner.findById(idinfopartner)
    console.log(updatepartner2)
    
    updatepartner2.carinfoID.push(carinfopartner._id)
    updatepartner2.save()

})

router.post('/update_register_rentcarinfo',async (req,res) => { 
    console.log('update_register_rentcarinfo')  
    console.log(idinfocar)  
    // const infouser = await User.findById(req.body.username)
    const updatecarinfopartner = await rentcarinfo.findById(idinfocar)
    for(i = 1;i<3;i++){
        updatecarinfopartner.car_image.push(req.body.image[i])
    }
    for(i = 1;i<5;i++){
        updatecarinfopartner.car_service.push(req.body.name_service[i])
    }
    for(i = 1;i<4;i++){
        updatecarinfopartner.car_locationpickup.push(req.body.locationpickup[i])
    }
    for(i = 1;i<4;i++){
        updatecarinfopartner.car_pricelocationpickup.push(req.body.pricelocationpickup[i])
    }
    
    updatecarinfopartner.save()
   

})

router.post('/regis_rentcarinfo',async (req,res) => { 
    console.log('register_rentcarinfo')    
    

    const carinfopartner = await new rentcarinfo({
        PartnerID: mongoose.Types.ObjectId('62134d4c6201bfd271838567'),
        car_name: req.body.carname,
        car_brand: req.body.carbrand,
        car_registration_year: req.body.year,
        car_nunber_sit: req.body.numsit,
        car_nunber_bigbag: req.body.bigbag,
        car_nunber_smallbag: req.body.smallbag,
        car_location: req.body.location,
        car_country: req.body.country,
        car_price: req.body.price,
        car_price_minute: req.body.price_minute,
        car_partnername: req.body.partnername,
        car_license: req.body.license,
        car_rating: req.body.rating,
        
    })
    carinfopartner.save()
    idinfocar = carinfopartner._id.toString()
    var updatepartner2 = await rentcarpartner.findById('62134d4c6201bfd271838567')
    updatepartner2.carinfoID.push(carinfopartner._id)
    updatepartner2.save()
    
   

})

router.post('/update_regis_rentcarinfo',async (req,res) => { 
    console.log('update_register_rentcarinfo')    

    // const infouser = await User.findById(req.body.username)
    console.log(idinfocar)  
    const updatecarinfopartner = await rentcarinfo.findOne({ _id: ObjectId(idinfocar) });
    for(i = 1;i<3;i++){
        updatecarinfopartner.car_image.push(req.body.image[i])
    }
    for(i = 1;i<5;i++){
        updatecarinfopartner.car_service.push(req.body.name_service[i])
    }
    for(i = 1;i<4;i++){
        updatecarinfopartner.car_locationpickup.push(req.body.locationpickup[i])
    }
    for(i = 1;i<4;i++){
        updatecarinfopartner.car_pricelocationpickup.push(req.body.pricelocationpickup[i])
    }
    updatecarinfopartner.save()
   

})

router.post('/getcarinfo',async (req,res) => { 
    console.log('getcarinfo')    

    // const infouser = await User.findById(req.body.username)
    console.log(req.body.country)  
    const infocar = await rentcarinfo.find({ "car_country": req.body.country });
    console.log(infocar)  
    

})

router.get('/:id' + '/infocar', (req,res) => {
    console.log('getdetailcar')
    console.log(req.params.id)
    rentcarinfo.findById(req.params.id).exec((err,foundCar) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundCar})
            console.log(foundCar)
        }
    })
   
})

router.get('/:partnerid' + '/infopartner', (req,res) => {
    console.log('getdetailpartner')
    var id = req.params.partnerid;
    console.log(id)
    rentcarpartner.findById(id).exec((err,foundpartner) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundpartner})
            console.log(foundpartner)
        }
    })
   
})

router.get('/:id' + '/queryrentcar' , (req,res) => {
    console.log('getmanycar')
    var country = req.params.id;
    console.log(country)
    rentcarinfo.find({ "car_country": country }).exec((err,foundCar) => {
        if(err){
            console.log(err)
        } else {
            res.json({foundCar})
        }
    })
})

router.post('/save_transaction',async (req,res) =>  { 
    console.log('save_transaction')
    console.log(req.body.usernameid)
    const receipt = await new rentcarreceipt({
        usernameID: mongoose.Types.ObjectId(req.body.usernameid),
        partnername: req.body.partnername,
        car_name: req.body.car_name,
        car_license : req.body.car_license,
        date_sentcar: req.body.date_sentcar,
        date_getcar: req.body.date_getcar,
        time_getcar: req.body.time_getcar,
        time_sentcar: req.body.time_sentcar,
        location_getsentcar: req.body.location,
        detail_pricedate: req.body.detail_pricedate,
        detail_pricetime:req.body.detail_pricetime,
        detail_pricelocation: req.body.detail_pricelocation,
        sum_detail_pricedate: req.body.sum_detail_pricedate,
        sum_detail_pricetime: req.body.sum_detail_pricetime,
        sum_detail_pricelocation: req.body.sum_detail_pricelocation,
        total_price: req.body.total_price, 
    })
    receipt.save()
    console.log(req.body.carid)
    var result = await rentcarinfo.findById(req.body.carid)
    console.log(result)
    console.log(result.car_counting)
    var result2 = await rentcarinfo.updateOne({_id:req.body.carid},{$set:{car_counting:result.car_counting+1}})
  
    res.json({receipt})
})


module.exports = router