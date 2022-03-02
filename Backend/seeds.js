var mongoose = require('mongoose');
    Hotel = require('./models/hotel_model');
    Room = require('./models/room_model');
    Restaurant = require('./models/restau_model');
    Attraction = require('./models/attraction_model');


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

var restautestData = [
    {
        name : 'fullpearl',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 2000,
        star : 3,
        type : "cruise",
        openday : "เปิดทำการ จันทร์ - เสาร์" ,
        time : "เวลา 08:00น. - 22:00น.",
        desc : 'อิ่มพุงกางกับกว่า 50 เมนูทั้งของคาว ของหวาน เครื่องดื่ม ที่จะทำให้คุณน้ำลายสอ\nดื่มด่ำรสชาติบนเรือสำราญสุด exclusive\nเติมความหวานปิดท้ายด้วยไอศครีมหลากหลายรสชาติและ เครื่องดื่มเพิ่มความสดชื่น'
    }, 
    {
        name : 'the ozone',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 3000,
        star : 5,
        type : "seafood",
        openday : "เปิดทำการทุกวัน" ,
        time : "เวลา 10:00น. - 22:00น.",
        desc : 'อิ่มพุงกางกับกว่า 100 เมนูทั้งของคาว ของหวาน เครื่องดื่ม ที่จะทำให้คุณน้ำลายสอ\nดื่มด่ำรสชาติความสดอร่อยของซีฟู้ดด้วยแพ็กเกจบุฟเฟ่ต์ Deluxe\nเติมความหวานปิดท้ายด้วยไอศครีมหลากหลายรสชาติและ เครื่องดื่มเพิ่มความสดชื่น'
    },
    {
        name : 'fullpearl2',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 2000,
        star : 3,
        type : "cruise",
        openday : "เปิดทำการ จันทร์ - เสาร์" ,
        time : "เวลา 08:00น. - 22:00น.",
        desc : 'อิ่มพุงกางกับกว่า 50 เมนูทั้งของคาว ของหวาน เครื่องดื่ม ที่จะทำให้คุณน้ำลายสอ\nดื่มด่ำรสชาติบนเรือสำราญสุด exclusive\nเติมความหวานปิดท้ายด้วยไอศครีมหลากหลายรสชาติและ เครื่องดื่มเพิ่มความสดชื่น'
    },
    {
        name : 'the ozone2',
        image: 'https://placeimg.com/640/480/any',
        location: 'นาจอมเทียน, พัทยา',
        price : 3000,
        star : 5,
        type : "seafood",
        openday : "เปิดทำการทุกวัน" ,
        time : "เวลา 10:00น. - 22:00น.",
        desc : 'อิ่มพุงกางกับกว่า 100 เมนูทั้งของคาว ของหวาน เครื่องดื่ม ที่จะทำให้คุณน้ำลายสอ\nดื่มด่ำรสชาติความสดอร่อยของซีฟู้ดด้วยแพ็กเกจบุฟเฟ่ต์ Deluxe\nเติมความหวานปิดท้ายด้วยไอศครีมหลากหลายรสชาติและ เครื่องดื่มเพิ่มความสดชื่น'
    }

]
var attractionData = [
    {
        name : 'Similan island',
        image: 'https://placeimg.com/640/480/any',
        location: 'เมืองภูเก็ต',
        price : 2000,
        star : 3,
        type : "sea",
        openday : "เปิดทำการ จันทร์ - เสาร์" ,
        time : "เวลา 08:00น. - 22:00น.",
        desc : 'พบกับน้ำทะเลสีฟ้าครามระยิบระยับที่ผืนทรายบนเกาะสิมิลัน\nขึ้นไปที่หินใบเรือที่มีชื่อเสียงและเพลิดเพลินกับทัศนียภาพที่น่าตื่นตาตื่นใจจากที่นั่น\nเยี่ยมชมจุดดำน้ำตื้น 2 แห่งและดำดิ่งลงไปในน้ำที่มีปลาหลากสีสันอาศัยอยู่\nอาบแดดและพักผ่อนบนชายหาดที่สวยงาม'
    }, 
    {
        name : 'pp island',
        image: 'https://placeimg.com/640/480/any',
        location: 'เมืองภูเก็ต',
        price : 2000,
        star : 3,
        type : "sea",
        openday : "เปิดทำการ จันทร์ - เสาร์" ,
        time : "เวลา 08:00น. - 22:00น.",
        desc : 'พบกับน้ำทะเลสีฟ้าครามระยิบระยับที่ผืนทรายบนเกาะสิมิลัน\nขึ้นไปที่หินใบเรือที่มีชื่อเสียงและเพลิดเพลินกับทัศนียภาพที่น่าตื่นตาตื่นใจจากที่นั่น\nเยี่ยมชมจุดดำน้ำตื้น 2 แห่งและดำดิ่งลงไปในน้ำที่มีปลาหลากสีสันอาศัยอยู่\nอาบแดดและพักผ่อนบนชายหาดที่สวยงาม'
    }, 
    {
        name : 'future city',
        image: 'https://placeimg.com/640/480/any',
        location: 'เมืองสมุทรปราการ',
        price : 3000,
        star : 5,
        type : "museum",
        openday : "เปิดทำการทุกวัน" ,
        time : "เวลา 10:00น. - 22:00น.",
        desc : 'พบกับเมืองโบราณ\nและเพลิดเพลินกับทัศนียภาพที่น่าตื่นตาตื่นใจจากที่นั่น\nเยี่ยมชมจุดตระการตา 2 แห่งและดำดิ่งลงไปในถ้ำที่มีหินหลากสีสันอยู่\nค้นหาและสำรวจบนเมืองโบราณที่สวยงาม'
    },
    {
        name : 'Ancient city',
        image: 'https://placeimg.com/640/480/any',
        location: 'เมืองสมุทรปราการ',
        price : 3000,
        star : 5,
        type : "museum",
        openday : "เปิดทำการทุกวัน" ,
        time : "เวลา 10:00น. - 22:00น.",
        desc : 'พบกับเมืองโบราณ\nและเพลิดเพลินกับทัศนียภาพที่น่าตื่นตาตื่นใจจากที่นั่น\nเยี่ยมชมจุดตระการตา 2 แห่งและดำดิ่งลงไปในถ้ำที่มีหินหลากสีสันอยู่\nค้นหาและสำรวจบนเมืองโบราณที่สวยงาม'
    }

]

function seedDB(){
    // Hotel.findById("61f04dae8c8b54240f0cffea" , (err, foundHotel) => {
    //     if(err){
    //         console.log(err)
    //     } else {
    //         Room.create(roomdata , (err,roomAdded) => {
    //             if(err){
    //                 console.log(err)
    //             } else {
    //                 foundHotel.room.push(roomAdded);
    //                 foundHotel.save()
    //             }
    //         })
    //     }
    // })

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
    Restaurant.remove({},(err) => {
        if(err){
            console.log(err)
        } else{
            Restaurant.create(restautestData , (err,roomAdded) => {
                if(err){
                    console.log(err)
                } else {
                    console.log('added')
                }
            })
        }
    })
    Attraction.remove({},(err) => {
        if(err){
            console.log(err)
        } else{
            Attraction.create(attractionData , (err,roomAdded) => {
                if(err){
                    console.log(err)
                } else {
                    console.log('added')
                }
            })
        }
    })
}

module.exports = seedDB;