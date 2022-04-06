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
    else if (type == 'flight')
      return Icon(Icons.airplanemode_active,
          color: Color(0xff1D3557),
          size: 20);
    else if (type == 'transfer')
      return Icon(Icons.directions_car,
          color: Color(0xff1D3557),
          size: 20);
    else if (type == 'rentcar')
      return Icon(Icons.car_rental,
          color: Color(0xff1D3557),
          size: 20);
    else if (type == 'activity')
      return Icon(Icons.star,
          color: Color(0xff1D3557),
          size: 20);
    else
      return Icon(Icons.location_city_sharp,
          color: Color(0xff1D3557),
          size: 20);
  }
}
