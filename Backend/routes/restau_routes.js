const express  = require('express');
const Restaurant = require('../models/restau_model')
const middleware = require('../middleware')
const User = require('../models/user_model')

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

router.get('/search/:word', middleware.isLoggedIn , (req,res) => {
    var searchWord = req.params.word
    Restaurant.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundRestaurant) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                foundRestaurant.forEach(elem => {
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
                res.status(200).json({restaurants:ElemList})
            })
        }
    })
})

router.get('/search/:word', middleware.isLoggedIn , (req,res) => {
    var searchWord = req.params.word
    Restaurant.find({$or:[{name:{$regex:searchWord,$options:'i'}}
    ,{location:{$regex:searchWord,$options:'i'}}]},(err , foundRestaurant) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                foundRestaurant.forEach(elem => {
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
                res.status(200).json({restaurants:ElemList})
            })
        }
    })
}
)

router.get('/getData/:word', middleware.isLoggedIn , (req,res) => {
    var searchWord = req.params.word
    Restaurant.findById(req.params.word).exec((err,foundRes) => {
        if(err){
        console.log(err)
    } else {
        var user = middleware.getUser(req)
        User.findById(user._id).exec((err,foundUser) => {
            if (err) return console.log(err);
                // get favorite
                var foundFav = false
                foundUser.favorite.some(favelem => {
                    if ( favelem.id.equals(foundRes._id) ) {
                        foundFav = true
                    }
                })
            console.log(foundFav)
            res.status(200).json({foundRes: foundRes, userFavourited: foundFav})
        })
    }}
    )
}
)

router.get('/', middleware.isLoggedIn , (req,res) => {
    console.log("seafood")

    Restaurant.find({type : "seafood"},(err , foundseafood) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                foundseafood.forEach(elem => {
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
                res.status(200).json({seafoodrestaurant:ElemList})
            })
        }
    })
})

router.get('/getcruise', middleware.isLoggedIn  , (req,res) => {
    console.log("cruise")

    Restaurant.find({type : "cruise"},(err , foundcruise) => {
        if(err){
            console.log(err)
        } else {
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                foundcruise.forEach(elem => {
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
                res.status(200).json({cruiserestaurant:ElemList})
            })
        }
    })
})

router.get('/querydata/:word', middleware.isLoggedIn , (req,res) => {
    console.log("query")
    console.log(req.params.word)
    var searchWord = req.params.word
    Restaurant.findById(req.params.word).exec((err,foundRestaurant) => {
        if(err){
        console.log(err)
    } else {
        var user = middleware.getUser(req)
        User.findById(user._id).exec((err,foundUser) => {
            if (err) return console.log(err);
                // get favorite
                var foundFav = false
                foundUser.favorite.some(favelem => {
                    if ( favelem.id.equals(foundRestaurant._id) ) {
                        foundFav = true
                    }
                })
            console.log(foundFav)
            res.status(200).json({foundRestaurant: foundRestaurant, userFavourited: foundFav})
        })
    }}
    )}
    
)

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
                    favModel : 'Restaurant'
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