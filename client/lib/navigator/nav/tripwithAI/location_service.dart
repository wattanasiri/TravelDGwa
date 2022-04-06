import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class LocationService{
  final String key = 'AIzaSyAGo_066grp7TfW3FNglU7gnBH2TRHb2UM';

  Future<String> getPlaceId(String input) async{
    // final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    // var response = await http.get(Uri.parse(url));
    // print(response.statusCode);
    // var json = convert.jsonDecode(response.body);
    // var placeId = json['candidates'][0]['place_id'] as String;
    // print('placeId');
    // print(placeId);
    // return placeId;
    return '0';
  }

  Future<String> getladlong(String input) async{
    print('getlatlong');
    print(input);
    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    print(locations[0].longitude);
    return '0';
  }


// Future<Map<String, dynamic>> getPlace(String input) async{}
}