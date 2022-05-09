const express = require('express');
const app = express();
const port = process.env.PORT || 5000; // 5000 is used for heroku server
const host = '0.0.0.0';
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const passport = require('passport')
const LocalStrategy = require('passport-local')

const seedDB = require('./seeds');

const User = require('./models/user_model');

mongoose.connect('mongodb+srv://admin:se1235@cluster0.inezx.mongodb.net/TravelDGwa?retryWrites=true&w=majority')

const SecretText = 'it\'s a secret to everyone.'

var exportElements = {};
exportElements.SecretText = SecretText
module.exports = exportElements;

app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())

app.use((err, req, res, next) => {
  var statusCode = err.status || 500
  res.status(statusCode)
  res.json({
    error: {
      status: statusCode,
      message: err.message
    }
  });
});

app.use(require('express-session')({
  secret: SecretText,
  resave: false,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());

passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());


passport.use(new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password'
  },
  User.authenticate()
));

app.use(async function(req,res,next){
  res.locals.message = req.user;
  console.log(res.locals)
  next();
});

app.use('/',require('./routes/user_routes'))
app.use('/airport_transfer', require('./routes/airport_transfer_routes'))
app.use('/hotel',require('./routes/hotel_routes'))
app.use('/transaction',require('./routes/transaction_routes'))
app.use('/booking',require('./routes/booking_routes'))
app.use('/comment',require('./routes/comment_routes'))
app.use('/rentcar',require('./routes/rentcar_routes'))
app.use('/activity',require('./routes/activity_routes'))
app.use('/restaurant',require('./routes/restau_routes'))
app.use('/attraction',require('./routes/attraction_routes'))
app.use('/admin',require('./routes/admin_routes'))
app.use('/blog',require('./routes/blog_routes'))
app.use('/map',require('./routes/map_routes'))

passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

// seedDB()

app.use(function(req,res,next) {
  res.locals.currentUser = req.user;
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept')
  next();
});

app.listen(port, () => {
    console.log('port running on port : ' + port)
})