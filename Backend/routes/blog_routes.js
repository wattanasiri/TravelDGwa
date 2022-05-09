const express  = require('express')
const jwt = require('jwt-simple')
const { UserExistsError } = require('passport-local-mongoose/lib/errors')
const secret = require('..').SecretText
const Blog = require('../models/blog_model')
const User = require('../models/user_model')

const router = express.Router()

router.get('/recent',(req,res) => {
    Blog.find().sort({date:1}).limit(10).exec((err,RecentBlog) => {
        if(err){
            console.log(err)
        } else {
            res.json({recentBlog : RecentBlog})
        }
    })
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

module.exports = router