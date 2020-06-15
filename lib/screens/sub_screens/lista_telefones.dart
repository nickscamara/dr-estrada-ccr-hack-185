import 'package:ccrhack/util/tel_rodovias.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaTelefones extends StatelessWidget {
  const ListaTelefones({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Telefones Rodovias",style: TextStyle(color: Colors.white),),),
      body: ListView.builder(
        itemCount: listaTelefonicas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listaTelefonicas[index].name,style: TextStyle(color: Theme.of(context).primaryColor),),
            trailing:Text(listaTelefonicas[index].tel),
            onTap: (){
              _launchCall("tel:"+listaTelefonicas[index].tel);
            },
          );
        },
      ),
    );
  }

_launchCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}