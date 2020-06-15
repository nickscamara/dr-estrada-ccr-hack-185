import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction{
   String polyline;
   int distance;
   String distanceText;
   int duration;
   String durationText;
   String pickupAddress;
   String deliverAddress;
   LatLng currentLocation;
  
  Direction({
    this.deliverAddress,this.currentLocation,
    this.distance,this.duration,this.pickupAddress,this.polyline,this.distanceText,this.durationText
  });
}