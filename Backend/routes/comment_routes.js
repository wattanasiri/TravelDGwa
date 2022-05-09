const express  = require('express');
const middleware = require('../middleware')
const Comment = require('../models/comment_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple');
const Hotel = require('../models/hotel_model');
const Restaurant = require('../models/restau_model');
const Attraction = require('../models/attraction_model')
const Activity = require('../models/activity_model')
const Blog = require('../models/blog_model')
const rentcarpartner = require('../models/rentcar_partner_model');
const secret = require('..').SecretText

const router = express.Router()

// get Model
function getModelType(type) {
    if (type == 'attraction') {
        return Attraction
    } else if (type == 'hotel') {
        return Hotel
    } else if (type == 'restaurant') {
        return Restaurant
    } else if (type == 'rentcarpartner') {
        return rentcarpartner
    } else if (type == 'activity') {
        return Activity
    } else if (type == 'blog') {
        return Blog
    }
    else {
        return 1;
    }
}

// get Comment
router.get('/:id/model/:type' , middleware.isLoggedIn, (req,res) => {
    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)
    var commentList = []

    var Model = getModelType(req.params.type)
    if (Model === 1) return console.log('Invalid model type')

    Model.findById(req.params.id).populate('comments').exec(function(err, foundModel) {
        if (err) return console.log(err)
        var userLikedState = false
        var userDislikedState = false

        if (foundModel) {
            foundModel.comments.forEach(function(comment) {
                // reset variable every loop
                userLikedState = false
                userDislikedState = false

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

    var Model = getModelType(req.params.type)
    if (Model === 1) return console.log('Invalid model type')

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
                        // calculate rating before updating one
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

router.put('/:commentid' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    Comment.findByIdAndUpdate(req.params.commentid, req.body, function(err, updatedComment) {
        if (err) return console.log(err)
        if (updatedComment) {
            var Model = getModelType(updatedComment.type)
            if (Model === 1) return res.status(401).json()
            Model.findById(req.body.id).populate('comments').exec(function(err, foundModel) {
                if (err) return console.log(err);
                if (foundModel) {
                    // calculate rating before updating one
                    var averageRating = 0
                    var commentCount = 0
                    var totalRating = 0
                    foundModel.comments.forEach(function(comment) {
                        commentCount += 1 
                        totalRating += comment.rating
                        // console.log(comment)
                    });
                    if (commentCount == 0) {
                        // should not happen ever
                        averageRating = req.body.rating
                    } else {
                        averageRating = (totalRating) / ( commentCount )
                    } 
                    
                    console.log(averageRating)
                    foundModel.updateOne({ $set: { star : averageRating }}).exec()
                    foundModel.save()
                } else {
                    return console.log(err);
                }
            });
            return res.status(200).json()
        } else {
            return res.status(404).json()
        }
    })
})

router.delete('/:commentid' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    var commentType;

    Comment.findById(
        req.params.commentid
        , function(err, targetComment) {
        if (err) return console.log(err)
        commentType = targetComment.type

        Comment.findByIdAndDelete(req.params.commentid, function(err) {
            if (err) return console.log(err)
            var Model = getModelType(commentType)
            if (Model === 1) return console.log('Invalid model');
            Model.findById(req.body.id).populate('comments').exec(function(err, foundModel) {
                if (err) return console.log(err);
                if (foundModel) {
                    // calculate rating before updating one
                    var averageRating = 0
                    var commentCount = 0
                    var totalRating = 0
                    foundModel.comments.forEach(function(comment) {
                        commentCount += 1 
                        totalRating += comment.rating
                        // console.log(comment)
                    });
                    if (commentCount == 0) {
                        averageRating = 0
                    } else {
                        averageRating = (totalRating) / ( commentCount )
                    } 
                    
                    console.log(averageRating)
                    foundModel.updateOne({ $set: { star : averageRating }}).exec()
                    foundModel.save()
                } else {
                    return console.log(err);
                }
            });
            return res.status(200).json()
        })
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