import 'package:ccrhack/services/google_maps_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConsulataLocal extends StatelessWidget {

  final LatLng location;
  final String address;
  final String title;
  final String img;

  ConsulataLocal(this.location,this.address,this.title,this.img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Marcar Consulta",style: TextStyle(color: Colors.white),),),
      body: ListView(
        children: [
          customCard(context)
        ],
      )
    );
  }
  Widget customCard(context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.025),
              offset: Offset(0, 10),
              blurRadius: 5,
              spreadRadius: .5),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Local: " + title,style: TextStyle(fontSize: 18))
            ],
          ),
          Text("Endereco: " + address,style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor),)
        ],
      ),
    );
  }
}