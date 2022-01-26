var mongoose = require('mongoose');
    Hotel = require('./models/hotel_model');
    Room = require('./models/room_model');


var roomdata = 
// [
    {
        room_name : 'Normal',
        image : [
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Hotel-room-renaissance-columbus-ohio.jpg/1024px-Hotel-room-renaissance-columbus-ohio.jpg',
            'https://www.italianbark.com/wp-content/uploads/2018/01/Muji-Hotel-Shenzhen-03-hotel-room-design-trends-italianbark-.jpg'
        ],
        price : 1000,
        area : 22,
    }
    // {
    //     room_name : 'Suite',
    //     image : [
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Hotel-room-renaissance-columbus-ohio.jpg/1024px-Hotel-room-renaissance-columbus-ohio.jpg',
    //         'https://www.italianbark.com/wp-content/uploads/2018/01/Muji-Hotel-Shenzhen-03-hotel-room-design-trends-italianbark-.jpg'
    //     ],
    //     price : 4000,
    //     area : 30,
    // }

// ]

var testData = [
    {
        name : 'Cape Dara Resort',
        image: 'https://placeimg.com/640/480/any',
        location: '256 หาดดารา ซ.20 ถ.พัทยานาเกลือ พัทยาเหนือ, นาเกลือ, พัทยา, ชลบุรี, ประเทศไทย, 20150',
        price : 1000,
        star : 4,
        room : [

        ],
        desc : 'เคป ดารา รีสอร์ท เป็นที่พักอันยอดเยี่ยมสำหรับผู้ไปเยือนพัทยา ไม่ว่าจะเพื่อพักผ่อนท่องเที่ยวหรือติดต่อธุรกิจจากที่พักท่านสามารถเดินทาง ได้อย่างสะดวกง่ายดายไปยังทุกที่ในเมืองที่มีชีวิตชีวานี้ อีกทั้งยังอยู่ใกล้ วงเวียนโลมา, เทวารัณย์ สปา, สถานกงสุลกิติมศักดิ์สวีเดน อีกด้วย'
    }, 
    {
        name : 'Cape Hotel',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 2000,
        star : 3,
        desc : 'โรงแรมเคป เป็นที่พักอันยอดเยี่ยมสำหรับผู้ไปเยือนพัทยา ไม่ว่าจะเพื่อพักผ่อนท่องเที่ยวหรือติดต่อธุรกิจจากที่พักท่านสามารถเดินทาง ได้อย่างสะดวกง่ายดายไปยังทุกที่ในเมืองที่มีชีวิตชีวานี้ อีกทั้งยังอยู่ใกล้ วงเวียนโลมา, เทวารัณย์ สปา, สถานกงสุลกิติมศักดิ์สวีเดน อีกด้วย'
    }, 
    {
        name : 'Ambassador city Jomtien',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 3000,
        star : 5,
        desc : 'Ambassador เป็นที่พักอันยอดเยี่ยมสำหรับผู้ไปเยือนพัทยา ไม่ว่าจะเพื่อพักผ่อนท่องเที่ยวหรือติดต่อธุรกิจจากที่พักท่านสามารถเดินทาง ได้อย่างสะดวกง่ายดายไปยังทุกที่ในเมืองที่มีชีวิตชีวานี้ อีกทั้งยังอยู่ใกล้ วงเวียนโลมา, เทวารัณย์ สปา, สถานกงสุลกิติมศักดิ์สวีเดน อีกด้วย'
    }
]

function seedDB(){
    Hotel.findById("61f04dae8c8b54240f0cffea" , (err, foundHotel) => {
        if(err){
            console.log(err)
        } else {
            Room.create(roomdata , (err,roomAdded) => {
                if(err){
                    console.log(err)
                } else {
                    foundHotel.room.push(roomAdded);
                    foundHotel.save()
                }
            })
        }
    })

    // Hotel.remove({} , (err) => {
    //     if(err){
    //         console.log(err)
    //     }
    //     console.log('Hotel remove')
    //     Hotel.create(testData, (err) => {
    //         if(err){
    //             console.log(err)
    //         } else {
    //             console.log('Hotel added')
    //         }
    //     });
    // });
}

module.exports = seedDB;