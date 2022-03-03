import 'package:flutter/material.dart';

class BookingTypeIcon extends StatelessWidget {
  const BookingTypeIcon({
    Key key,
    this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    if (type == 'accommodation')
    return Icon(Icons.location_city_sharp,
          color: Color(0xff1D3557),
          size: 20);
    else if (type == 'transferrecipt')
      return Icon(Icons.directions_car,
          color: Color(0xff1D3557),
          size: 20);
    else
      return Icon(Icons.location_city_sharp,
          color: Color(0xff1D3557),
          size: 20);
  }
}
