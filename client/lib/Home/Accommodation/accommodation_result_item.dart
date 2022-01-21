import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';

class Items {
  String name;
  String price;
  String priceDecrease;
  String image;
  String location;
  int rate;
  bool isFavorite;
  Items({this.name, this.price, this.priceDecrease, this.image, this.location, this.rate, this.isFavorite});
}

class ResultItem extends StatefulWidget {

  @override
  State<ResultItem> createState() => _ResultItemState();

}

class _ResultItemState extends State<ResultItem> {

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  Items item1 = Items(
    name: 'Cape Dara Resort',
    price: '1,100.00',
    priceDecrease: '2,100.00',
    image: 'https://placeimg.com/640/480/any',
    location: 'นาจอมเทียน, พัทยา',
    rate: 5,
    isFavorite: false
  );

  Items item2 = Items(
      name: 'Ambassador City Jomtien Pattaya',
      price: '3,000.00',
      priceDecrease: '5,000.00',
      image: 'https://placeimg.com/640/480/any',
      location: 'นาจอมเทียน, พัทยา',
      rate: 4,
      isFavorite: false
  );

  Items item3 = Items(
      name: 'The Grass Serviced Suites by At Mind',
      price: '3,000.00',
      priceDecrease: '',
      image: 'https://placeimg.com/640/480/any',
      location: 'พัทยาใต้, พัทยา',
      rate: 5,
      isFavorite: false
  );

  @override
  Widget build(BuildContext context) {

    List<Items> itemList = [item1, item2, item3];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 1,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(right: 10, bottom: 100, left: 10),
        children: itemList.map((data) {
          return GestureDetector(
            onTap: () => {

            },
            child: GFCard(
              color: const Color(0xff1D3557),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.zero,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              child: Image.network(
                                  data.image,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              height: 30,
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: _buildRatingStars(data.rate),
                            ),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 15),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xffECFAFF),
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: const Color(0xff1D3557), width: 3)
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_rounded,
                                color: data.isFavorite ? const Color(0xffE80138) : const Color(0xffC4C4C4),
                              ),
                              iconSize: 30,
                              onPressed: () => {
                                setState(() => data.isFavorite = !data.isFavorite)
                              },
                            )
                        ),
                      ]
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 200,
                              child: Text(
                                data.name,
                                style: const TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'THB ' + data.price,
                                  style: const TextStyle(
                                      color: Color(0xffF69B12),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                                Text(
                                  data.priceDecrease,
                                  style: const TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.location_pin, color: Color(0xffFFF4DC),),
                            const SizedBox(width: 5),
                            Text(
                              data.location,
                              style: const TextStyle(
                                  color: Color(0xffFFF4DC),
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
