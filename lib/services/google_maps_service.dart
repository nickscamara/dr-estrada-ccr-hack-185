  
import 'package:async/async.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
const apiKey = "AIzaSyA6xxnNLCZl9mJCbuccfXEGFy4VvuGQA8E";

class ResultAddress{
  final String name;
  final String address;
  final Location location;
  final String img;

  ResultAddress(this.name, this.address,this.location,this.img);

}

class GoogleMapsServices{

  Future<List<ResultAddress>> searchHospitals(int resultsLength) async
  {
    try{
    final places = new GoogleMapsPlaces(apiKey: apiKey);
      PlacesSearchResponse response = await places.searchByText("Hospital",language: "pt-BR",radius: 12000);
    if(!response.hasNoResults)
    {
      List<ResultAddress> results = new List<ResultAddress>();
      for(var i = 0; i < response.results.length; i++)
      {
        ResultAddress addR = new ResultAddress(response.results[i].name,response.results[i].formattedAddress,response.results[i].geometry.location,response.results[i].icon);
        results.add(addR);
        if(i == resultsLength)
        {
          break;
        }
      }
      return results;
    }
    return [];

    }catch(e)
    {
      return [];
    }
    
    

  }

  Future<LatLng> getCurrentLocation() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return new LatLng(position.latitude,position.longitude);
  }

  // Future<Direction> getRouteCoordinates(LatLng l1, LatLng l2)async{
  //   print("requesting");
  //   String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
  //   http.Response response = await http.get(url);
  //   Map values = jsonDecode(response.body);
  //   //LatLng currentLocation = await getCurrentLocation();
  //   Direction direction = new Direction(
  //     currentLocation: l1,
  //     polyline: values["routes"][0]["overview_polyline"]["points"],
  //     durationText: values["routes"][0]["legs"][0]["duration"]["text"],
  //     duration: values["routes"][0]["legs"][0]["duration"]["value"],
  //     distance: values["routes"][0]["legs"][0]["duration"]["value"],
  //     distanceText: values["routes"][0]["legs"][0]["distance"]["text"],
  //     pickupAddress: values["routes"][0]["legs"][0]["start_address"],
  //     deliverAddress: values["routes"][0]["legs"][0]["end_address"],

  //   );
  //   return direction;
  //}
}