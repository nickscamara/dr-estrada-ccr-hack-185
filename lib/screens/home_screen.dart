import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccrhack/screens/chat_virtual.dart';
import 'package:ccrhack/screens/sub_screens/lista_telefones.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {

  final Function(int screen) notifyParent;
  HomeScreen(this.notifyParent);
  

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
  readLast();

    return SafeArea(
        child: Container(
            padding: EdgeInsets.only(left:25,top:25,right: 25),
          child: ListView(
            children: [
              header(),
              SizedBox(
                  height: 15,
                ),
              headingTitle("Cuidado a Saúde"),
              subTitle("Seu bem-estar sempre em primeiro lugar"),
              SizedBox(
                  height: 15,
                ),
              saudeBtns(),
               SizedBox(
                  height: 15,
                ),
              headingTitle("Cuidados Preventivos"),
              subTitle("Você pode acompanhar tudo por aqui"),
              SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
              smallCardSaude(context, Icon(FontAwesomeIcons.heart,color:Colors.red),"Prontuários","Recente",()=> widget.notifyParent(3)),
               smallCardSaude(context, Icon(Icons.person,color:Theme.of(context).primaryColor),"de Saúde Digital","Agente",()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatVirtual()))),

                ],),
                SizedBox(
                  height: 15,
                ),
              truckCard(),

             // cards(context),
              SizedBox(
                  height: 15,
                ),
                headingTitle("Atividade"),
              subTitle(""),
              cardActivity(),
            ],
          ),
        ),
      );
  }
  Widget cardActivity()
  {
     return Container(
      padding: EdgeInsets.all(15),
      height: 100,
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
      child: FutureBuilder<double>(
        future: readLast(),
        builder: (context, snapshot) {
          if(snapshot.data != null  &&  snapshot.connectionState == ConnectionState.done )
          {
            return ListTile(
            leading: Icon(FontAwesomeIcons.walking,color: Theme.of(context).primaryColor,size: 30,),
            title: Text("Passos", style: TextStyle(fontSize: 18),),
            subtitle: Text("Hoje, 14 de Junho", style: TextStyle(fontSize: 14),),
            trailing: Text(snapshot.data.floor().toString(),style: TextStyle(fontSize: 25)),
          );

          }
          return Container();
          
        }
      ),
    );

  }
  Future<double> readLast() async {
  final result = await FitKit.read(DataType.STEP_COUNT,dateFrom: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),dateTo: DateTime.now());
  double sum = 0;
  for(var i in result)
  {
    sum += i.value;
  }
  print(sum);
 return sum;
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchSamu() async {
  const url = 'tel:192';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  Widget saudeBtns()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          smallCardBtn(context, Icon(FontAwesomeIcons.phone,color:Colors.green), "Ligar SAMU",() => _launchSamu()),
          SizedBox(width: 12.5,),
          smallCardBtn(context, Icon(FontAwesomeIcons.hospital,color:Colors.red), "Unidades P/A",() => widget.notifyParent(1)),
          SizedBox(width: 12.5,),
          smallCardBtn(context, Icon(FontAwesomeIcons.road,color:Colors.blue), "Telefone Rodovia",() => Navigator.push(context, MaterialPageRoute(builder: (_)=>ListaTelefones()))),
      ]
      );
  }

  Widget header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        subHeader(context),
        Container(
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network("https://picsum.photos/id/188/200/200"),
          ),
        ),
      ],
    );
  }

  Widget subHeader(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Olá,",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        AutoSizeText(
          "Ricardo!",
          style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget customCard() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).secondaryHeaderColor
        ]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.025),
              offset: Offset(0, 10),
              blurRadius: 5,
              spreadRadius: .5),
        ],
      ),
    );
  }

  Widget truckCard() {
    return Container(
      decoration: BoxDecoration(
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        color: Colors.white,
    
    child: InkWell(
      borderRadius:BorderRadius.circular(15),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.3),
      focusColor:Theme.of(context).primaryColor.withOpacity(.3),
      splashColor:Theme.of(context).primaryColor  .withOpacity(.3),
      onTap: () async {
       await _launchURL("https://ciadaconsulta.com.br/ccr");

      },
          child: Container(
        height: 135,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   // gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor]),
        //   borderRadius: BorderRadius.circular(25),
        //   boxShadow: [
        //     BoxShadow(
        //         color: Colors.black.withOpacity(.025),
        //         offset: Offset(0, 10),
        //         blurRadius: 5,
        //         spreadRadius: .5),
        //   ],
        // ),
        child: Stack(
          children: [
            Padding(
                  padding: const EdgeInsets.only(left:8.0,top: 8.0,right: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset("assets/img/marcar_consulta.png",width: 150,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Marcar Consulta",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22, fontWeight: FontWeight.bold),),
                        Container(
                          width: 125,
                          child: AutoSizeText("Você pode marcar uma consulta direto com o CiaSaude da CCR", maxLines:3, style: TextStyle(color:Colors.black.withOpacity(.75),fontSize: 15, fontWeight: FontWeight.w300),)),
                      ],
                    )),
                ),
          ],
        ),),),
      ),
    );
  }

  Widget statsCard(IconData icon, String text) {
    return Container(
      height: 100,
      width: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        // gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor]),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget greenHeadingTitle(String text)
  {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Text(text,style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))
    );
  }

  Widget headingTitle(String text)
  {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Text(text,style: TextStyle(fontSize: 18,color: Colors.black.withOpacity(.9),fontWeight: FontWeight.bold))
    );
  }

  Widget subTitle(String text)
  {
    return Padding(
      padding: EdgeInsets.only(left:0),
      child: Text(text,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(.3),fontWeight: FontWeight.w300))
    );
  }

  Widget cards(context)
  {
    return Column(
       mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AutoSizeText("Temos tudo o que você precisa",style: TextStyle(color:Colors.black.withOpacity(.9),fontSize:17, fontWeight: FontWeight.bold),),
         SizedBox(height: 10,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           smallCard(context, Icons.access_alarm,"Alarme"),
            smallCard(context, Icons.person_pin,"Meu Dr."),
             smallCard(context, Icons.collections_bookmark,"Exames"),

         ],),
         SizedBox(height: 10,),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           smallCard(context, Icons.phone,"SOS"),
            smallCard(context, Icons.people,"Medicos"),
             smallCard(context, Icons.receipt,"Nota Fiscal"),

         ],)
      ],);
  }
Widget smallCardBtn(context,Icon icon, String title, Function onTap)
  {
    return Container(
      decoration: BoxDecoration(
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        color: Colors.white,
    child: InkWell(
      borderRadius:BorderRadius.circular(15),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.3),
      focusColor:Theme.of(context).primaryColor.withOpacity(.3),
      splashColor:Theme.of(context).primaryColor  .withOpacity(.3),
      onTap: onTap,
    child: 
    Container(
        width: 100,
        height: 100,
        
       
                   child: Container(
                      padding: EdgeInsets.only(top:15,bottom: 15,left: 20,right: 20),
                     child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      icon,
      Spacer(),
      AutoSizeText(title,maxLines: 2,textAlign: TextAlign.center,),

    ],
          ),
                   ),
    ),),),
      );
  }
  Widget smallCardSaude(context,Icon icon, String title, String subTitle, Function onTap)
  {
    return Container(
      decoration: BoxDecoration(
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        color: Colors.white,
            child: InkWell(
          borderRadius:BorderRadius.circular(15),
          highlightColor: Theme.of(context).primaryColor.withOpacity(.3),
          focusColor:Theme.of(context).primaryColor.withOpacity(.3),
          splashColor:Theme.of(context).primaryColor  .withOpacity(.3),
          onTap: onTap,
              child: Container(
            width: 165,
            height: 95,
                 padding: EdgeInsets.all(20),

            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            icon,
            SizedBox(width: 10,),
                   AutoSizeText(subTitle,maxLines: 1,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 5,),
                AutoSizeText(title,maxLines: 1,textAlign: TextAlign.center,),

              ],
            ),

          ),
        ),
      ),
    );
  }
  Widget smallCard(context,IconData icon, String title)
  {
    return Container(
      width: 100,
      height: 95,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,color: Theme.of(context).primaryColor),
          SizedBox(height: 5,),
          AutoSizeText(title,maxLines: 1,textAlign: TextAlign.center,),

        ],
      ),

    );
  }
}