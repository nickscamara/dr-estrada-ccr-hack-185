import 'package:ccrhack/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:introduction_screen/introduction_screen.dart' as page;
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<page.PageViewModel> list = [
    PageViewModel(
      title: "Seja bem-vindo!",
      body:
          "Aqui nossa missão é cuidar da sua saúde na estrada",
      image: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Image.asset("assets/img/welcome_ccr.png", height: 205.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
        bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
    PageViewModel(
      title: "Cuide da sua saúde de dentro do caminhão",
      body:
          "Com o nosso aplicativo, acompanharemos seu bem-estar de uma forma simplificada",
      image: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Image.asset("assets/img/health_ccr.png", height: 205.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
        bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
    PageViewModel(
      title: "De qualquer lugar",
      body:
          "Sua saúde na palma da mão em qualquer lugar pra qualquer hora! ",
      image: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Image.asset("assets/img/map_ccr.png", height: 205.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
        bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
    PageViewModel(
      title: "Vamos começar",
      body:
          "Fique tranquilo, o cadastro leva menos de 1 minuto.",
      image: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Image.asset("assets/img/start_ccr.png", height: 205.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
        bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // _readHallPreference().then((value) {

    //    if(value!=null)
    //    {

    //   Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(
    //                       builder: (context) => HomePage(hall: value, flutterLocalNotificationsPlugin:flutterLocalNotificationsPlugin),
    //                     ), (e) => false);
    // }});

    return IntroductionScreen(
      pages: list,
      onDone: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      )),
      onSkip: () {
        // You can also override onSkip callback
      },
      showSkipButton: true,
      skip: const Text(""),
      next: const Icon(Icons.arrow_forward, color: Colors.black),
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).primaryColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }

  Future<List<String>> _readHallPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'hall_selected';
    final value = prefs.getStringList(key);
    if (value == null || value == []) {
      return null;
    }

    return value;
  }
}
