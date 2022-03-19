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

// get Comment
router.get('/:id/comment' , middleware.isLoggedIn, (req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    var commentList = []

    Attraction.findById(req.params.id).populate('comments').exec(function(err, foundModel) {
        if (err) return console.log(err)
        if (foundModel) {
            foundModel.comments.forEach(function(comment) {

                // comment.likedby.forEach(function(like) {
                //     console.log()
                // })

                var newComment = {
                    // did this because i can't assign key to comment element directly
                    id: comment._id,
                    username: comment.author.username,
                    type: comment.type,
                    text: comment.text,
                    date: comment.date,
                    time: comment.time,
                    rating : comment.rating,
                    like: comment.like,
                    dislike: comment.dislike,
                    userLiked: false,
                    userDisliked: false,
                    belongToUser: user._id == comment.author.id,
                }
                commentList.push(newComment)
            });
            console.log(commentList);
            res.json({comment:commentList})
        } else {
            console.log(err)    
        }
    });
})

router.post('/:id/comment' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    Attraction.findById(req.params.id, function(err, foundAttraction) {
        if (err) return console.log(err);
        if (foundAttraction) {

            Comment.create(
                {}
                , function(err, newComment) {
                if (err) return console.log(err);
                
                console.log()

                newComment.author.id = user._id
                newComment.author.username = user.realname + ' ' + user.surname
                newComment.type = req.body.type
                newComment.text = req.body.text
                newComment.date = req.body.date
                newComment.time = req.body.time
                newComment.rating = req.body.rating
                foundAttraction.comments.push(newComment)

                var averageRating = 0

                Attraction.findById(req.params.id).populate('comments').exec(function(err, foundAttraction2) {
                    if (err) return console.log(err);
                    if (foundAttraction2) {
                        var commentCount = 0
                        var totalRating = 0
                        foundAttraction2.comments.forEach(function(comment) {
                            commentCount += 1 
                            totalRating += comment.rating
                            // console.log(comment)
                        });
                        if (commentCount == 0) {
                            averageRating = req.body.rating
                        } else {
                            averageRating = (totalRating+req.body.rating) / ( commentCount + 1 )
                        } 
                        
                        console.log(averageRating)
                        foundAttraction.updateOne({ $set: { star : averageRating }}).exec()
                        newComment.save()
                        foundAttraction.save()
                    } else {
                        return console.log(err);
                    }
                });


                res.status(200).json()

            });
        } else {
            return res.status(404).json()
        }
    });
})


module.exports = router