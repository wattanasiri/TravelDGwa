var midwareFunctions = {};

midwareFunctions.isLoggedIn = function(req, res, next){
    if(req.isAuthenticated()){
      console.log('logged in')
      return next();
    } else {
      console.log('not logged in')
      return next();
    }
};

module.exports = midwareFunctions; 