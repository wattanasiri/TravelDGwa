const express  = require('express');
const _  = require('lodash');
const middleware = require('../middleware')
const Comment = require('../models/comment_model')
const User = require('../models/user_model')
const jwt = require('jwt-simple');
const secret = require('..').SecretText

const router = express.Router()

// TODO: insert code for like, dislike and editing

router.post('/:id/like' , middleware.isLoggedIn , (req,res) => {

    var token = req.headers.authorization.split(' ')[1]
    var stringToken = JSON.parse(token)['token']
    var user = jwt.decode(stringToken, secret)

    
})


module.exports = router