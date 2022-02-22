const express = require('express');
const app = express();
const port = 8080 || process.env.PORT;
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const passport = require('passport')
const LocalStrategy = require('passport-local')

const seedDB = require('./seeds');

const User = require('./models/user_model');

mongoose.connect('mongodb+srv://admin:se1235@cluster0.inezx.mongodb.net/TravelDGwa?retryWrites=true&w=majority')

app.use(require('express-session')({
  secret: 'it\'s a secret to everyone.',
  resave: false,
  saveUninitialized: false
}));

app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use(passport.initialize());
app.use(passport.session());
passport.use(new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password'
  },
  User.authenticate()
));

app.use('/',require('./routes/user_routes'))
app.use('/shuttle', require('./routes/shuttle_routes'))
app.use('/hotel',require('./routes/hotel_routes'))

passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

// seedDB()

app.listen(port, () => {
    console.log('port running on port : ' + port)
})