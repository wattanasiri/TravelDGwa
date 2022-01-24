var mongoose = require('mongoose');
    Hotel = require('./models/hotel_model');

var testData = [
    {
        name : 'Cape Dara Resort',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 1000,
        star : 4
    }, 
    {
        name : 'Cape Hotel',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 2000,
        star : 3
    }, 
    {
        name : 'Ambassador city Jomtien',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 3000,
        star : 5
    }
]

function seedDB(){
    Hotel.remove({} , (err) => {
        if(err){
            console.log(err)
        }
        console.log('Hotel remove')
        Hotel.create(testData, (err) => {
            if(err){
                console.log(err)
            } else {
                console.log('Hotel added')
            }
        });
    });
}

module.exports = seedDB;