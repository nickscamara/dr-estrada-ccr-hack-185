import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccrhack/helpers/bitmap.dart';
import 'package:ccrhack/model/direction.dart';
import 'package:ccrhack/screens/consulta_local.dart';
import 'package:ccrhack/services/google_maps_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class MapSample extends StatefulWidget {
  final LatLng currentLoc;
  MapSample(this.currentLoc);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool loading = true;
  double _maxHeight = 250;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  PanelController _panelController = PanelController();
  static LatLng latLng;
  LocationData currentLocation;
  TextEditingController add = TextEditingController();
  TextEditingController add2 = TextEditingController();
  ResultAddress resultAddress = new ResultAddress(null, null, null, null);
  ResultAddress resultAddress2 = new ResultAddress(null, null, null, null);
  Direction order;

  List<ResultAddress> hospitaisProximos = [];

  final kGoogleApiKey = "AIzaSyA6xxnNLCZl9mJCbuccfXEGFy4VvuGQA8E";
  // Future<Position> locateUser() async {
  //   return Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      getLocation();
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // loading = true;
    super.initState();
    _searchGMapsAdd1();
  }

  // getUserLocation() async {
  //   __currentLocation = await locateUser();
  //   setState(() {
  //     latLng = LatLng(__currentLocation.latitude, __currentLocation.longitude);
  //     _onAddMarkerButtonPressed();
  //   });
  //   print('center:====== $latLng');
  // }

  getLocation() async {
    setState(() {
      latLng = widget.currentLoc;
    });
    // _addMarker(await _googleMapsServices.getCurrentLocation(), address)
    //_onAddMarkerButtonPressed();
    loading = false;
    //sendRequest();
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        infoWindow: InfoWindow(
            title:
                "Sua localizacao"), //snippet: widget.order.directionFinal.pickupAddress),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
  }

  void _addMarker(
    LatLng location,
    String address,
    String id,
    String title,
    double hue,
    String img,
  ) async {
    BitmapDescriptor bitmapDescriptor;
    // if (titleIcon != null) {
    //   bitmapDescriptor = await createCustomMarkerBitmap(titleIcon);
    // }
    _controller.future
        .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: location, zoom: 14.4746, bearing: 25.0, tilt: 35.0),
            )));
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
            title: title,
            snippet: address,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ConsulataLocal(location, address, title, img)));
            }),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed), //titleIcon == null
        //?
        //: bitmapDescriptor,
      ));
    });
  }

  void _addInitialMarker(LatLng location, String address, String id) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
            title: "Minha localização", snippet: address, onTap: () {}),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    // // final direction = await _googleMapsServices.getRouteCoor(
    // //     LatLng(resultAddress.location.lat, resultAddress.location.lng),
    // //     LatLng(resultAddress2.location.lat, resultAddress2.location.lng));
    // Direction route0 = direction;
    // order = route0;
    // setState(() {
    //   createRoute(route0.polyline, 0);
    // });
    // //if success
    // _panelController.animatePanelToPosition(1);
  }

  //0 dir0, 1 dir1
  void createRoute(String encondedPoly, int x) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: x == 0 ? Colors.lightGreen : Theme.of(context).primaryColor));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    // print(lList.toString());

    return lList;
  }

  LatLng getTarget() {
    if (resultAddress2.location != null) {
      return LatLng(
        resultAddress2.location.lat,
        resultAddress2.location.lng,
      );
    } else if (resultAddress.location != null) {
      return LatLng(
        resultAddress.location.lat,
        resultAddress.location.lng,
      );
    } else {
      return LatLng(latLng.latitude, latLng.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
//    print("getLocation111:$latLng");
    return Scaffold(
      appBar: AppBar(
         leading: Container(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ])),
        ),
        title: Text(
          "Hospitais Próximos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            polylines: polyLines,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: getTarget(),
              zoom: 14.4746,
            ),
            onCameraMove: onCameraMove,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              listHospitais(),
              SizedBox(height: 5,)
              //addressWidget2(),
            ],
          )),
          // SlidingUpPanel(
          //   color: Colors.transparent,
          //   boxShadow: null,
          //   minHeight: order == null ? 0 : _maxHeight,
          //   maxHeight: _maxHeight,
          //   controller: _panelController,
          //   panel: _orderDetails(),
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(23.0),
          //     topRight: Radius.circular(23.0),
          //   ),
          // )
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){
      //     sendRequest();
      //   },
      //   label: Text('Destination'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget listHospitais() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: hospitaisProximos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              print("awda");
              await _launchURL(
                  "http://maps.google.com/?q=${hospitaisProximos[index].location.lat},${hospitaisProximos[index].location.lng}");
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        hospitaisProximos[index].name,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                     child: Icon(FontAwesomeIcons.hospitalSymbol,color: Colors.red),),
                  ],
                ),
                // child: Stack(
                //   children: [
                //   //  Icon(FontAwesomeIcons.hospitalSymbol,color: Colors.red),
                //     Align(
                //       alignment: Alignment.bottomRight,
                //                         child:
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _orderDetails() {
    return order != null
        ? Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              // gradient: LinearGradient(
              //       colors: [Theme.of(context).primaryColor, Colors.blue])
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    height: 130,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "assets/img/delivery_time.png",
                            width: 28,
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            order.durationText,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              "Tempo do trajeto",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white.withOpacity(.5),
                                  fontWeight: FontWeight.w100),
                            ))
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).bottomAppBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    height: 130,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "assets/img/delivery.png",
                            width: 28,
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            order.distanceText,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              "Distância do trajeto",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white.withOpacity(.5),
                                  fontWeight: FontWeight.w100),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 130,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.lightBlue, Colors.lightBlue]),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {},
                    // => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => SubmitOrderScreen(
                    //             order, resultAddress, resultAddress2))),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ))
        : Container();
  }

  Widget addressDialog(List<ResultAddress> addresses) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addresses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(addresses[index].address),
            onTap: () => Navigator.pop(context, addresses[index]),
          );
        },
      ),
    );
  }

  _searchGMapsAdd1() async {
    await _googleMapsServices.searchHospitals(5).then((value) async {
      hospitaisProximos = value;
      for (var i = 0; i < value.length; i++) {
        _addMarker(
            LatLng(value[i].location.lat, value[i].location.lng),
            value[i].address,
            value[i].name,
            value[i].name,
            BitmapDescriptor.hueGreen,
            value[i].img);
      }
      setState(() {});
    });
  }

  _searchGMapsAdd2() async {
    await _googleMapsServices.searchHospitals(5).then((value) async {
      try {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Endereço'),
                content: addressDialog(value),
              );
            }).then((value) {
          _addMarker(
              LatLng(value.location.lat, value.location.lng),
              value.address,
              "345",
              "Local de entrega",
              BitmapDescriptor.hueBlue,
              value.img);
          setState(() {
            resultAddress2 = value;
            add2.text = value.address;
          });
          FocusScope.of(context).requestFocus(FocusNode());
          sendRequest();
        });
      } catch (e) {}
    });
  }

  Widget addressWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 25, right: 25),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: TextField(
            onTap: () {
              _maxHeight = 0;
              _panelController.close();
            },
            onEditingComplete: () async {
              polyLines.clear();
              _maxHeight = 250;
              _searchGMapsAdd1();
            },
            controller: add,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              hintText: "Local de retirada",
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressWidget2() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 5, right: 25),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: TextField(
            onTap: () {
              _maxHeight = 0;
              _panelController.close();
            },
            onEditingComplete: () async {
              polyLines.clear();
              _maxHeight = 250;
              _searchGMapsAdd2();
            },
            controller: add2,
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.motorcycle,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              hintText: "Local de entrega",
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15),
            ),
          ),
        ),
      ),
    );
  }
}
