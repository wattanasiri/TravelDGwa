const User = require('../models/user_model')

var f = {};

f.getFav = function(user, List) {
  User.findById(user._id).exec((err,foundUser) => {
    if (err) return console.log(err);

    var ObjectList = []
    List.forEach(elem => {
        // get favorite
        var foundFav = false
        foundUser.favorite.some(elem2 => {
            if ( elem2.id.equals(elem._id) ) {
                foundFav = true
                console.log('found')
            }
        })
        let newData = Object.assign(elem.toObject(), {userFavourited: foundFav})
        ObjectList.push(newData)
    });
    
    console.log(ObjectList)
    return ObjectList;
  })

}

module.exports = f;  