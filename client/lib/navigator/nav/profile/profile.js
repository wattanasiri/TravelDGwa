const mongoose = require("mongoose")
const Schema = mongoose.Schema

const profileSchema = new Schema({
    name : String,
    propicture : String
})

module.exports = mongoose.model("User",profileschema)