const express  = require('express');
const Hotel = require('../models/hotel_model')

const router = express.Router()

// router.post('/search' , (req,res) => {
//     var searchWord = req.body.searchWord;
//     Hotel.find({$or:[{name:{$regex:searchWord,$options:'i'}}
//     ,{location:{$regex:searchWord,$options:'i'}}]} , (err , foundHotel) => {
//         if(err){
//             console.log(err);
//         } else {
//             console.log(foundHotel)
//             res.json(foundHotel);
//         }
//     })
// })

// router.get('/search/:word' , (req,res) => {
//     var searchWord = req.params.word;
//     Hotel.find({$or:[{name:{$regex:searchWord,$options:'i'}}
//     ,{location:{$regex:searchWord,$options:'i'}}]} , (err , foundHotel) => {
//         if(err){
//             console.log(err);
//         } else {
//             console.log(foundHotel);
//             res.json({hotels:foundHotel});
//         }
//     })
// })

router.get('/:id/room' , (req,res) => {
    var hotelId = req.params.id;
    Hotel.findById(hotelId).populate('room').exec((err,foundRoom) => {
        if(err){
            console.log(err)
        } else {
            res.json({rooms:foundRoom})
            console.log(foundRoom)
        }
    })
})

router.get('/search/:word', (req,res) => {
    console.log(res.locals.currentUser.email)
    var searchWord = req.params.word
    Hotel.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]}).populate('room')
    .exec((err , foundHotel) => {
        if(err){
            console.log(err)
        } else {
            foundHotel.forEach(hotel => {
                hotel['room'].sort(function (a,b) {
                    return a.price - b.price;
                })
                hotel['price'] = hotel['room'][0]['price'];
            });
            res.json({hotels:foundHotel});
        }
    })
})
module.exports = router