const express  = require('express')
const Hotel = require('../models/hotel_model')

const router = express.Router()

router.post('/search' , (req,res) => {
    var searchWord = req.body.searchWord;
    Hotel.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]} , (err , foundHotel) => {
        if(err){
            console.log(err);
        } else {
            console.log(foundHotel)
            res.json(foundHotel);
        }
    })
})

router.get('/search/:word' , (req,res) => {
    var searchWord = req.params.word;
    Hotel.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]} , (err , foundHotel) => {
        if(err){
            console.log(err);
        } else {
            console.log(foundHotel)
            res.json({hotels:foundHotel});
        }
    })
})

module.exports = router