router.post('/transaction' , (req,res) => {
    var details = []
    
    AccomTransaction.create({   acc_name : req.body.acc_name,
                                checkIn : req.body.checkIn,
                                checkOut : req.body.checkOut,
                                list : req.body.list} , (err,createdTransaction) => {
                                    if(err) {
                                        console.log(err)
                                        res.json(err)
                                    } else {
                                        res.json(createdTransaction)
                                    }
                                })
})