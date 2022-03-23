const express  = require('express');
const Restaurant = require('../models/restau_model')

const router = express.Router()

// router.get('/:id' , (req,res) => {
//     var restaurantId = req.params.id
//     Restaurant.findById(restaurantId,(err,foundRes) => {
//         if(err){
//             console.log(err)
//         } else {
//             res.json({res:foundRes})
//             console.log(foundRes)
//         }
//     })
// })

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

router.get('/' , (req,res) => {
    console.log("seafood")

    Restaurant.find({type : "seafood"},(err , foundseafood) => {
        if(err){
            console.log(err)
        } else {

            res.json({seafoodrestaurant:foundseafood});
        }
    })
})

router.get('/getcruise' , (req,res) => {
    console.log("cruise")

    Restaurant.find({type : "cruise"},(err , foundcruise) => {
        if(err){
            console.log(err)
        } else {

            res.json({cruiserestaurant:foundcruise});
        }
    })
})

router.get('/querydata/:word', (req,res) => {
    console.log("query")
    console.log(req.params.word)
    var searchWord = req.params.word
    Restaurant.findById(req.params.word).exec((err,foundRestaurant) => {
        if(err){
        console.log(err)
    } else {

        res.json({foundRestaurant});
    }}
    )}
    
)

module.exports = router