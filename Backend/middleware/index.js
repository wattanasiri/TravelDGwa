const jwt = require('jwt-simple')
const secret = require('..').SecretText
const User = require('../models/user_model')

var midwareFunctions = {};

midwareFunctions.isLoggedIn = function(req, res, next){
  if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
      // the incoming token is 'Bearer #token#'
      var token = req.headers.authorization.split(' ')[1]
      // we need to convert the string to JSON object first.
      var stringToken = JSON.parse(token)['token']
      var decodedtoken = jwt.decode(stringToken, secret)
      User.findById(decodedtoken._id, function (err, foundUser) {
        if (err){
          // console.log('not logged in')
          return res.status(401).json({success: false, message: 'Invalid token.'})
        }
        else {
          if (!foundUser) {
            // console.log('not logged in')
            return res.status(401).json({success: false, message: 'Invalid token.'})
          } else {
            // console.log('logged in')
            return next();
          }
        }
    });
      
    } else {
      // console.log('not logged in')
      return res.status(401).json({success: false, message: 'Invalid token.'})
    }
};

// not a middleware function but well
midwareFunctions.getUser = function(req) {
  var token = req.headers.authorization.split(' ')[1]
  var stringToken = JSON.parse(token)['token']
  var user = jwt.decode(stringToken, secret)
  return user
}

module.exports = midwareFunctions;  