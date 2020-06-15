import 'package:ccrhack/model/medico.dart';
import 'package:flutter/material.dart';

class ReceituarioScreen extends StatelessWidget {
  final medico = new Medico(
      name: "Geraldo Ricardo",
      img: "https://picsum.photos/id/237/200/200",
      valor: "15,00",
      crm: "13212");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
           leading: Container(),
           elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Receitas e Exames",
            style: TextStyle(color: Theme.of(context).accentColor)),
          bottom: TabBar(
            labelStyle: TextStyle(color:Theme.of(context).primaryColor),
            unselectedLabelColor: Theme.of(context).secondaryHeaderColor,
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Text("Receitas"),
                  icon: Icon(
                Icons.calendar_today,
              )),
              Tab(
                 child: Text("Exames"),
                icon: Icon(Icons.book)),
            ],
          ),
        ),
        body: TabBarView(
          
          children: [
            ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text("Consulta 18/09 - Medico Geraldo",style: TextStyle(color: Colors.black),),
                  children: <Widget>[
                    _medicoDetails(context),
                    remedios(context),
                  ],
                ),
                ExpansionTile(
                  title: Text("Consulta 15/09 - Medico Amilton",style: TextStyle(color: Colors.black),),
                  children: <Widget>[
                    _medicoDetails(context),
                    remedios(context),
                  ],
                )
              ],
            ),ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text("Exame 18/09 - Medico Geraldo",style: TextStyle(color: Colors.black),),
                  children: <Widget>[
                    _medicoDetails(context),
                    remedios(context),
                  ],
                ),
                ExpansionTile(
                  title: Text("Exame 15/09 - Medico Amilton",style: TextStyle(color: Colors.black),),
                  children: <Widget>[
                    _medicoDetails(context),
                    remedios(context),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget remedios(context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Remédios"),
              ),
              ListTile(
                title: Text(
                  "Adivil",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text("2 vezes ao dia por 7 dias"),
                trailing: Text("150mg"),
              ),
              ListTile(
                title: Text(
                  "Novalgina",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text("2 vezes ao dia por 7 dias"),
                trailing: Text("1g"),
              ),
              ListTile(
                title: Text(
                  "Ibuprofeno",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text("3 vezes ao dia por 5 dias"),
                trailing: Text("250mg"),
              ),
            ],
          ),
        ));
  }

  Widget _medicoDetails(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text(
              medico.name,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Text(
              "18/09/2020",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text("CRM: " + medico.crm),
            leading: SizedBox(
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  medico.img,
                ),
              ),
            ),
          ),
          // Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 25,
          //     padding: EdgeInsets.all(5),
          //     child: Align(
          //         alignment: Alignment.center,
          //         child: Text(
          //           "R\$" + medico.valor,
          //           style: TextStyle(color: Colors.white),
          //         )),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(15),
          //           bottomRight: Radius.circular(15)),
          //       color: Theme.of(context).primaryColor,
          //     ))
        ],
      ),
    );
  }
}
