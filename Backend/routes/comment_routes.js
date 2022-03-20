const express  = require('express');
const middleware = require('../middleware')
const Attraction = require('../models/attraction_model')
const Comment = require('../models/comment_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple');
const secret = require('..').SecretText

const router = express.Router()

// TODO: insert code for like, dislike and editing

// get Comment
router.get('/:type/:id' , middleware.isLoggedIn, (req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    var commentList = []

    console.log('EEEEE comment type')

    var Model
    if (req.params.type == 'attraction') {
        Model = Attraction
    } else {
        return console.log('Invalid comment type')
    }

    Model.findById(req.params.id).populate('comments').exec(function(err, foundModel) {
        if (err) return console.log(err)
        if (foundModel) {
            foundModel.comments.forEach(function(comment) {

                // get variable if the user has liked the comment or not
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

router.post('/:type/:id' , middleware.isLoggedIn , (req,res) => {

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

router.post('/:id/like' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    
})


module.exports = router