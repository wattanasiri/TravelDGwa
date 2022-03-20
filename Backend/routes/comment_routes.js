const express  = require('express');
const middleware = require('../middleware')
const Attraction = require('../models/attraction_model')
const Comment = require('../models/comment_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple');
const Hotel = require('../models/hotel_model');
const Restaurant = require('../models/restau_model');
const rentcarpartner = require('../models/rentcar_partner_model');
const secret = require('..').SecretText

const router = express.Router()

// TODO: insert code for like, dislike and editing

// get Comment
router.get('/:id/model/:type' , middleware.isLoggedIn, (req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    var commentList = []

    var Model
    if (req.params.type == 'attraction') {
        Model = Attraction
    } else if (req.params.type == 'hotel') {
        Model = Hotel
    } else if (req.params.type == 'restaurant') {
        Model = Restaurant
    } else if (req.params.type == 'rentcarpartner') {
        Model = rentcar_partner_model
    }
    else {
        return console.log('Invalid comment type')
    }

    Model.findById(req.params.id).populate('comments').exec(function(err, foundModel) {
        if (err) return console.log(err)
        var userLikedState = false
        var userDislikedState = false

        if (foundModel) {
            foundModel.comments.forEach(function(comment) {

                // get variable if the user has liked the comment or not
                comment.likedby.some(userElem => {
                    if (user._id === userElem.toString()) {

                        console.log('found user')
                        userLikedState = true
                    } 
                })
                if (userLikedState === false) { // Don't check this if user already liked the comment
                    comment.dislikedby.some(userElem => {
                        if (user._id === userElem.toString()) {
    
                            console.log('found user')
                            userDislikedState = true
                        } 
                    })
                }
                

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
                    userLiked: userLikedState,
                    userDisliked: userDislikedState,
                    belongToUser: user._id == comment.author.id,
                }
                commentList.push(newComment)
            });
            // console.log(commentList);
            res.json({comment:commentList})
        } else {
            console.log(err)    
        }
    });
})

router.post('/:id/model/:type' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    var Model
    if (req.params.type == 'attraction') {
        Model = Attraction
    } else if (req.params.type == 'hotel') {
        Model = Hotel
    } else if (req.params.type == 'restaurant') {
        Model = Restaurant
    } else if (req.params.type == 'rentcarpartner') {
        Model = rentcar_partner_model
    }
    else {
        return console.log('Invalid comment type')
    }

    Model.findById(req.params.id, function(err, foundModel) {
        if (err) return console.log(err);
        if (foundModel) {

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
                foundModel.comments.push(newComment)

                var averageRating = 0

                Model.findById(req.params.id).populate('comments').exec(function(err, foundModel2) {
                    if (err) return console.log(err);
                    if (foundModel2) {
                        var commentCount = 0
                        var totalRating = 0
                        foundModel2.comments.forEach(function(comment) {
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
                        foundModel.updateOne({ $set: { star : averageRating }}).exec()
                        newComment.save()
                        foundModel.save()
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

router.post('/:commentid/like' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    Comment.findById(req.params.commentid, function(err, foundComment) {
        if (err) return console.log(err);
        if (foundComment) {

            var canAddLike = true

            // remove dislike
            foundComment.dislikedby.some(userElem => {
                if (user._id === userElem.toString()) {
                    foundComment.dislikedby.pull(user._id)
                    foundComment.updateOne({ $set: {
                        dislike : foundComment.dislike - 1 
                    }}).exec()
                    
                    console.log('dislike removed')
                } 
            })

            // unlike if already liked
            foundComment.likedby.some(userElem => {
                if (user._id === userElem.toString()) {
                    foundComment.likedby.pull(user._id)
                    foundComment.updateOne({ $set: {
                        like : foundComment.like - 1 
                    }}).exec()
                    
                    console.log('unlike')
                    canAddLike = false
                } 
            })

            if (canAddLike === true) {
                foundComment.likedby.push(user._id)
                foundComment.updateOne({ $set: {
                    like : foundComment.like + 1 
                }}).exec()

            }

            foundComment.save()
            return res.status(200).json()
            
        } else {
            return res.status(404).json()
        }
    });
})

router.post('/:commentid/dislike' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    Comment.findById(req.params.commentid, function(err, foundComment) {
        if (err) return console.log(err);
        if (foundComment) {

            var canAddDislike = true

            // remove like
            foundComment.likedby.some(function(userElem) {
                if (user._id === userElem.toString()) {
                    foundComment.likedby.pull(user._id)
                    foundComment.updateOne({ $set: {
                        like : foundComment.like - 1 
                    }}).exec()
                    
                    console.log('like removed')
                } 
            })

            // un-dislike if already disliked
            foundComment.dislikedby.some(function(userElem) {
                if (user._id === userElem.toString()) {
                    foundComment.dislikedby.pull(user._id)
                    foundComment.updateOne({ $set: {
                        dislike : foundComment.dislike - 1 
                    }}).exec()
                    
                    console.log('undislike')
                    canAddDislike = false
                } 
            })

            if (canAddDislike === true) {
                foundComment.dislikedby.push(user._id)
                foundComment.updateOne({ $set: {
                    dislike : foundComment.dislike + 1 
                }}).exec()
            }

            foundComment.save()
            return res.status(200).json()
            
        } else {
            return res.status(404).json()
        }
    });
})


module.exports = router