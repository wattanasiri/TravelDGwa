import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';

class ResultItem extends StatefulWidget {

  final resultData;
  const ResultItem({Key key, @required this.resultData})
      : super(key: key);
  @override
  State<ResultItem> createState() => _ResultItemState();

}

class _ResultItemState extends State<ResultItem> {

  var data;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  void initState() {
    super.initState();

    data = widget.resultData;
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {},
            child: GFCard(
              color: const Color(0xff1D3557),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.zero,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(alignment: Alignment.bottomRight, children: <Widget>[
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Image.network('${data[index]['image']}',
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 30,
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: _buildRatingStars(5),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffECFAFF),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                                color: const Color(0xff1D3557), width: 3)),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_rounded,
                              color:
                              // data.isFavorite
                              Color(0xffE80138)
                            // : const Color(0xffC4C4C4),
                          ),
                          iconSize: 30,
                          onPressed: () => {
                            // setState(() => data.isFavorite = !data.isFavorite)
                          },
                        )),
                  ]),
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
                                data[index]['name'],
                                style: const TextStyle(
                                    color: Color(0xffFFF4DC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const <Widget>[
                                Text(
                                  'THB ' + 'data price',
                                  style: TextStyle(
                                      color: Color(0xffF69B12),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'data priceDecrease',
                                  style: TextStyle(
                                      color: Color(0xffFFF4DC),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.location_pin,
                              color: Color(0xffFFF4DC),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data[index]['location'],
                              style: const TextStyle(
                                  color: Color(0xffFFF4DC), fontSize: 14),
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
        },
      ));
      // child: GridView.count(
      //   childAspectRatio: 1.0,
      //   crossAxisCount: 1,
      //   mainAxisSpacing: 20,
      //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      //   padding: const EdgeInsets.only(right: 20, bottom: 100, left: 20),
      //   children: itemList.map((data) {
      //     return GestureDetector(
      //       onTap: () => {
      //
      //       },
      //       child: GFCard(
      //         color: const Color(0xff1D3557),
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(20)
      //         ),
      //         padding: EdgeInsets.zero,
      //         content: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //             Stack(
      //                 alignment: Alignment.bottomRight,
      //                 children: <Widget>[
      //                   Column(
      //                     children: [
      //                       ClipRRect(
      //                         borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //                         child: Image.network(
      //                             data.image,
      //                             height: 200,
      //                             width: MediaQuery.of(context).size.width,
      //                             fit: BoxFit.cover
      //                         ),
      //                       ),
      //                       Container(
      //                         alignment: Alignment.topLeft,
      //                         height: 40,
      //                         color: Colors.transparent,
      //                         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      //                         child: Container(
      //                           padding: const EdgeInsets.only(top: 10),
      //                             child: _buildRatingStars(data.rate)
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Container(
      //                       margin: const EdgeInsets.only(right: 15),
      //                       width: 60,
      //                       height: 60,
      //                       decoration: BoxDecoration(
      //                           color: const Color(0xffECFAFF),
      //                           borderRadius: const BorderRadius.all(Radius.circular(30)),
      //                           border: Border.all(color: const Color(0xff1D3557), width: 3)
      //                       ),
      //                       child: IconButton(
      //                         icon: Icon(
      //                           Icons.favorite_rounded,
      //                           color: data.isFavorite ? const Color(0xffE80138) : const Color(0xffC4C4C4),
      //                         ),
      //                         iconSize: 30,
      //                         onPressed: () => {
      //                           setState(() => data.isFavorite = !data.isFavorite)
      //                         },
      //                       )
      //                   ),
      //                 ]
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 15),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       Container(
      //                         width: 160,
      //                         child: Text(
      //                           data.name,
      //                           style: const TextStyle(
      //                               color: Color(0xffFFF4DC),
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 18
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 140,
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.end,
      //                           children: <Widget>[
      //                             Text(
      //                               'THB ' + data.price,
      //                               style: const TextStyle(
      //                                   color: Color(0xffF69B12),
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 18
      //                               ),
      //                             ),
      //                             Text(
      //                               data.priceDecrease,
      //                               style: const TextStyle(
      //                                   color: Color(0xffFFF4DC),
      //                                   fontWeight: FontWeight.w500,
      //                                   fontSize: 16,
      //                                   decoration: TextDecoration.lineThrough
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: <Widget>[
      //                       const Icon(Icons.location_pin, color: Color(0xffFFF4DC),),
      //                       const SizedBox(width: 5),
      //                       Text(
      //                         data.location,
      //                         style: const TextStyle(
      //                             color: Color(0xffFFF4DC),
      //                             fontSize: 14
      //                         ),
      //                       )
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   }).toList(),
      // ),
  }
}
