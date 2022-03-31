const mongoose = require('mongoose')
var PartnerAccomSchema = mongoose.Schema({
    usernameID: {
        type :mongoose.Schema.Types.ObjectId,
        ref : 'User'
    },
})