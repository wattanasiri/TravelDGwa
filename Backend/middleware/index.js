var midwareFunctions = {};

midwareFunctions.isLoggedIn = function(req, res, next){
  if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
      console.log('logged in')
      return next();
    } else {
      console.log('not logged in')
      return res.json({success: false, message: 'invalid token'})
    }
};

module.exports = midwareFunctions;  