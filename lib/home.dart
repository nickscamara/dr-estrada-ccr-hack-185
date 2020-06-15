import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccrhack/screens/chat_virtual.dart';
import 'package:ccrhack/screens/home_screen.dart';
import 'package:ccrhack/screens/mapa_saude.dart';
import 'package:ccrhack/screens/noticia_screen.dart';
import 'package:ccrhack/screens/pre_chat_virtual.dart';
import 'package:ccrhack/screens/receituario_screen.dart';
import 'package:ccrhack/widgets/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _screens;
  int _currentIndex;

  notifyParent(index)
  {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    _currentIndex = 2;
     _screens = [
    NoticiasScreen(),
    MapSample(LatLng(-23.5892598,-46.7377281)),
    HomeScreen(notifyParent),
    ReceituarioScreen(),
    PreChatVirtual(),
    
  ];
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: Padding(
      padding: EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: const Alignment(0.7, -0.5),
                end: const Alignment(0.6, 0.5),
                colors: [
                  Theme.of(context).primaryColor,
                   Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home,color: Colors.white,size: 30,)
              ],
            ),
          ),
        ),
      ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        
        iconSize: 25,
        selectedItemColor: Color(0xff2EB872),
        unselectedItemColor: Colors.grey.withOpacity(.5),
         type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (int val) {
          setState(() {
            _currentIndex = val;
          });
          //returns tab id which is user tapped
        },
        currentIndex: _currentIndex,
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), title: Text('Notícias')),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), title: Text('Hospitais')),
          BottomNavigationBarItem(icon:Text(""), title: Text("")),
          BottomNavigationBarItem(icon:Icon( Icons.library_books), title: Text('Prontuário')),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('Assistente')),
        ],
      ),
    );
  }
  
}
