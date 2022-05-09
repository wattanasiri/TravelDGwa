const express  = require('express');
const middleware = require('../middleware')
const Attraction = require('../models/attraction_model')
const Comment = require('../models/comment_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple');
const secret = require('..').SecretText

const router = express.Router()

// router.get('/:id' , (req,res) => {
//     var attractionId = req.params.id
//     Attraction.findById(attractionId,(err,foundRes) => {
//         if(err){
//             console.log(err)
//         } else {
//             res.json({res:foundRes})
//             console.log(foundRes)
//         }
//     })
// })

router.get('/' , (req,res) => {
    console.log("1")

    Attraction.find({type : "sea"},(err , foundAttraction) => {
        if(err){
            console.log(err)
        } else {

            res.json({seaattraction:foundAttraction});
        }
    })
})

router.get('/getmuseum' , (req,res) => {
    console.log("museum")

    Attraction.find({type : "museum"},(err , foundmuseum) => {
        if(err){
            console.log(err)
        } else {

            res.json({museumattraction:foundmuseum});
        }
    })
})

router.get('/search/:word', (req,res) => {
    var searchWord = req.params.word
    Attraction.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundAttraction) => {
        if(err){
            console.log(err)
        } else {

            res.json({attraction:foundAttraction});
        }
    })
})

router.get('/getData/:word', (req,res) => {
    var searchWord = req.params.word
    Attraction.findById(req.params.word).exec((err,foundAttraction) => {
        if(err){
        console.log(err)
    } else {

        res.json({foundAttraction});
    }}
    )
}
)

router.get('/query/:word', (req,res) => {
    var searchWord = req.params.word
    Attraction.findById(req.params.word).exec((err,foundAttraction) => {
        if(err){
        console.log(err)
    } else {

        res.json({foundAttraction});
    }}
    )}
    
)

router.get('/getseaattraction/:word', (req,res) => {
    console.log("1")

    Attraction.find({type : "sea"},(err , foundAttraction) => {
        if(err){
            console.log(err)
        } else {

            res.json({seaattraction:foundAttraction});
        }
    })
})

module.exports = router