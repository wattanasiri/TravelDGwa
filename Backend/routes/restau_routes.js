const express  = require('express');
const Restaurant = require('../models/restau_model')

const router = express.Router()

router.get('/:id' , (req,res) => {
    var restaurantId = req.params.id
    Restaurant.findById(restaurantId,(err,foundRes) => {
        if(err){
            console.log(err)
        } else {
            res.json({res:foundRes})
            console.log(foundRes)
        }
    })
})

router.get('/search/:word', (req,res) => {
    var searchWord = req.params.word
    Restaurant.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundRestaurant) => {
        if(err){
            console.log(err)
        } else {

            res.json({restaurants:foundRestaurant});
        }
    })
})

router.get('/query/:word', (req,res) => {
    var searchWord = req.params.word
    Restaurant.findById(req.params.word).exec((err,foundRes) => {
        if(err){
        console.log(err)
    } else {

        res.json({foundRes});
    }}
    )}
    
)

router.get('/search/:word', (req,res) => {
    var searchWord = req.params.word
    Restaurant.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundRestaurant) => {
        if(err){
            console.log(err)
        } else {

            res.json({restaurants:foundRestaurant});
        }
    })
}
)

router.get('/getData/:word', (req,res) => {
    var searchWord = req.params.word
    Restaurant.findById(req.params.word).exec((err,foundRes) => {
        if(err){
        console.log(err)
    } else {

        res.json({foundRes});
    }}
    )
}
)

module.exports = router