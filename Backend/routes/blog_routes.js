const express  = require('express')
const jwt = require('jwt-simple')
const { UserExistsError } = require('passport-local-mongoose/lib/errors')
const middleware = require('../middleware')
const secret = require('..').SecretText
const Blog = require('../models/blog_model')
const User = require('../models/user_model')

const router = express.Router()

router.get('/recent', middleware.isLoggedIn,(req,res) => {
    Blog.find().sort({date:1}).limit(10).exec((err,RecentBlog) => {
        if(err){
            console.log(err)
        } else {
            console.log(RecentBlog)
            var user = middleware.getUser(req)
            User.findById(user._id).exec((err,foundUser) => {
                if (err) return console.log(err);
                var ElemList = []
                RecentBlog.forEach(elem => {
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
                res.status(200).json({recentBlog : ElemList})
            })
            // res.json({recentBlog : RecentBlog})
        }
    })
})

// only used in favorite page so far
router.get('/getData/:id', middleware.isLoggedIn, (req,res) => {
    Blog.findById(req.params.id).exec((err,foundBlog) => {
        if(err){
        console.log(err)
    } else {
        var user = middleware.getUser(req)
        User.findById(user._id).exec((err,foundUser) => {
            if (err) return console.log(err);
                // get favorite
                var foundFav = false
                foundUser.favorite.some(favelem => {
                    if ( favelem.id.equals(foundBlog._id) ) {
                        foundFav = true
                    }
                })
                console.log(foundFav)
                res.status(200).json({foundBlog: foundBlog, userFavourited: foundFav})
        })
    }}
    )
})

router.get('/author/:id',(req,res) => {
    User.findById(req.params.id,(err,author) => {
        if(err){
            console.log(err)
        } else {
            res.json(author)
        }
    })
})

router.post('/',(req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    Blog.create({
        authorId : user._id,
        image : req.body.image,
        topic : req.body.topic,
        location : req.body.location,
        desc : req.body.desc,
        date : req.body.date
    } , (err,createdBlog) => {
        if(err){
            console.log(err)
        } else {
            res.json(createdBlog)
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
                    favModel : 'Blog'
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