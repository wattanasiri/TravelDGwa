const express  = require('express');
const middleware = require('../middleware')
const Attraction = require('../models/attraction_model')
const User = require('../models/user_model')

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
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);

                var ElemList = []
                foundAttraction.forEach(elem => {
                    // get favorite
                    var foundFav = false
                    foundUser.favorite.some(favelem => {
                        if ( favelem.id.equals(elem._id) ) {
                            foundFav = true
                        }
                    })
                    let newData = Object.assign(elem.toObject(), {userFavourited: foundFav})
                    ElemList.push(newData)
                });
                res.status(200).json({seaattraction:ElemList})
            })
        }
    })
})

router.get('/getmuseum', (req,res) => {
    console.log("museum")

    Attraction.find({type : "museum"},(err , foundmuseum) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);

                var ElemList = []
                foundmuseum.forEach(elem => {
                    // get favorite
                    var foundFav = false
                    foundUser.favorite.some(favelem => {
                        if ( favelem.id.equals(elem._id) ) {
                            foundFav = true
                        }
                    })
                    let newData = Object.assign(elem.toObject(), {userFavourited: foundFav})
                    ElemList.push(newData)
                });
                res.status(200).json({museumattraction:ElemList})
            })
        }
    })
})

router.get('/search/:word', middleware.isLoggedIn, (req,res) => {
    var searchWord = req.params.word
    Attraction.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundAttraction) => {
        if(err){
            console.log(err)
        } else {

            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);

                var ElemList = []
                foundAttraction.forEach(elem => {
                    // get favorite
                    var foundFav = false
                    foundUser.favorite.some(favelem => {
                        if ( favelem.id.equals(elem._id) ) {
                            foundFav = true
                        }
                    })
                    let newData = Object.assign(elem.toObject(), {userFavourited: foundFav})
                    ElemList.push(newData)
                });
                res.status(200).json({attraction:ElemList})
            })
        }
    })
})

router.get('/getData/:word', middleware.isLoggedIn, (req,res) => {
    var searchWord = req.params.word
    Attraction.findById(req.params.word).exec((err,foundAttraction) => {
        if(err){
        console.log(err)
    } else {
        var user = middleware.getUser(req)
        User.findById(user._id).exec((err,foundUser) => {
            if (err) return console.log(err);
                // get favorite
                var foundFav = false
                foundUser.favorite.some(favelem => {
                    if ( favelem.id.equals(foundAttraction._id) ) {
                        foundFav = true
                    }
                })
                console.log(foundFav)
                res.status(200).json({foundAttraction: foundAttraction, userFavourited: foundFav})
        })
    }}
    )
}
)

router.get('/query/:word', middleware.isLoggedIn, (req,res) => {
    var searchWord = req.params.word
    Attraction.findById(req.params.word).exec((err,foundAttraction) => {
        if(err){
        console.log(err)
    } else {
        var user = middleware.getUser(req)
        User.findById(user._id).exec((err,foundUser) => {
            if (err) return console.log(err);
                // get favorite
                var foundFav = false
                foundUser.favorite.some(favelem => {
                    if ( favelem.id.equals(foundAttraction._id) ) {
                        foundFav = true
                    }
                })
                console.log(foundFav)
                res.status(200).json({foundAttraction: foundAttraction, userFavourited: foundFav})
            })
        }
    }
    )}
    
)

router.get('/getseaattraction/:word', middleware.isLoggedIn, (req,res) => {
    console.log("1")

    Attraction.find({type : "sea"},(err , foundAttraction) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                foundAttraction.forEach(elem => {
                    // get favorite
                    var foundFav = false
                    foundUser.favorite.some(favelem => {
                        if ( favelem.id.equals(elem._id) ) {
                            foundFav = true
                        }
                    })
                });
                res.status(200).json({seaattraction:foundAttraction})
            })
        }
    })
})

router.post('/:id/favourite' , middleware.isLoggedIn , (req,res) => {

    var user = middleware.getUser(req)

    User.findById(user._id, function(err, foundUser) {
        if (err) return console.log(err)
        if (foundUser) {

            var favRemoved = false
            // remove favourite
            foundUser.favorite.some(elem => {
                if (req.params.id === elem.id.toString()) {
                    favRemoved = true
                    foundUser.favorite.pull(elem)
                    console.log('favourite removed')
                } 
            })

            if (favRemoved == false) {
                var newFav = {
                    id : req.params.id,
                    favModel : 'Attraction'
                }
                foundUser.favorite.push(newFav)
            }
            foundUser.save()
        
            return res.status(200).json()
            
        } else {
            return res.status(404).json()
        }
    });
})

module.exports = router