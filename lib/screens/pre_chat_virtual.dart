import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccrhack/screens/chat_virtual.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreChatVirtual extends StatelessWidget {
  const PreChatVirtual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Assistente",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 25, top: 0, right: 25),
          child: ListView(children: [
            SizedBox(
              height: 25,
            ),
            commonCardHelp(
                context,
                AutoSizeText(
                  "Nada Ajudou?",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                "Fale com o assistente de saúde virtual",
                "",
                ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatVirtual())),
                Colors.red,),
                SizedBox(
              height: 15,
            ),
            commonCard(
                context,
                AutoSizeText(
                  "Sintomas de COVID-19?",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                "Teve contato com alguém infectado? Clique aqui para mais detalhes",
                "assets/img/covid.png",
                (){},
                Theme.of(context).primaryColor),
            SizedBox(
              height: 15,
            ),
            commonCard(
                context,
                AutoSizeText(
                  "Dor nas costas?",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                "O que você pode fazer hoje para não ter dor nas costas amanhã.",
                "assets/img/perna.png",
                (){},
                Theme.of(context).secondaryHeaderColor),
            SizedBox(
              height: 15,
            ),
            commonCard(
                context,
                AutoSizeText(
                  "Problemas de circulação?",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                "Uma ferramenta simples para diminuir as dores nas pernas.",
                "assets/img/distancia.png",
                (){},
                Theme.of(context).secondaryHeaderColor.withOpacity(.5)),
            SizedBox(
              height: 15,
            ),
            commonCard(
                context,
                AutoSizeText(
                  "Vacine contra gripe",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                "Clique aqui e veja os postos que oferecem vacinação.",
                "assets/img/vacc.png",
                (){},
                Colors.white),
          ])),
    );
  }
  Widget commonCardHelp(context, AutoSizeText title, String desc, String img,
      Function onTap, Color color) {
    return InkWell(
      borderRadius:BorderRadius.circular(25),
      highlightColor: Theme.of(context).accentColor.withOpacity(.3),
      focusColor:Theme.of(context).accentColor.withOpacity(.3),
      splashColor:Theme.of(context).accentColor  .withOpacity(.3),
      onTap: onTap,
          child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.025),
                offset: Offset(0, 10),
                blurRadius: 5,
                spreadRadius: .5),
          ],
        ),
        child: Ink(
          decoration: BoxDecoration(color: color,  borderRadius: BorderRadius.circular(25),),
                  child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        Container(
                            width: 250,
                            child: AutoSizeText(
                              desc,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.75),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            )),
                      ],
                    )),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebookMessenger,color: Colors.white,size: 30,),
                      onPressed: (){},
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonCard(context, AutoSizeText title, String desc, String img,
      Function onTap, Color color) {
    return InkWell(
      borderRadius:BorderRadius.circular(25),
      highlightColor: Theme.of(context).accentColor.withOpacity(.3),
      focusColor:Theme.of(context).accentColor.withOpacity(.3),
      splashColor:Theme.of(context).accentColor  .withOpacity(.3),
      onTap: onTap,
     child: Container(
      height: 150,
      decoration: BoxDecoration(
      
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.025),
              offset: Offset(0, 10),
              blurRadius: 5,
              spreadRadius: .5),
        ],
      ),
      child:  Ink(
          decoration: BoxDecoration(color: color,  borderRadius: BorderRadius.circular(25),),
              child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    img,
                    width: 125,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      Container(
                          width: 175,
                          child: AutoSizeText(
                            desc,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.black.withOpacity(.75),
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),),
    );
  }
}
