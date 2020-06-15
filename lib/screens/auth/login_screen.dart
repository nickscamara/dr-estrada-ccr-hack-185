import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:ccrhack/services/firebase_auth_service.dart';
import 'package:ccrhack/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginScreen extends StatefulWidget {
  static String get routeName => '@routes/welcome-page';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;

  bool hide = false;

  @override
  void initState() {
    super.initState();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: double.infinity,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/img/running5.jpg'), fit: BoxFit.cover)),
        child: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
          //   Color(0xff4f6ab2).withOpacity(.85),
          //   Colors.white.withOpacity(.1),
          // ])),
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Image.asset(
                      "assets/img/logo.png",
                      width: 500,
                    )),
                SizedBox(
                  height: 190,
                ),
                FadeAnimation(
                  1.7,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RaisedGradientButton(
                      onPressed: () {
                        _showSignUpModalSheet(context);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                      },
                      gradient: LinearGradient(
                        colors: <Color>[
                          Theme.of(context).primaryColor,
                           Theme.of(context).primaryColor,
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Vamos começar",
                          style: TextStyle(
                              color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
               
                FadeAnimation(
                    1.7,
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen())),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).secondaryHeaderColor),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Já têm cadastro? Clique aqui",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignUpModalSheet(context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);

    showModalBottomSheet(
      backgroundColor: Colors.grey.withOpacity(.1),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(25),
            height: 300,
            child:  Wrap(
              spacing: 10,
              children: <Widget>[
                Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(25),
                     color: Colors.white
                   ),
                   child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                       Icon(FontAwesomeIcons.phone,size: 15,),
                         Text(' Entrar com telefone',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      onTap: () => {authService.signInWithGoogle()}),
                 ),
                 SizedBox(height: 25,),
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(25),
                     color: Colors.white
                   ),
                   child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                       Icon(FontAwesomeIcons.google,size: 15,),
                         Text(' Entrar com email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      onTap: () => {authService.signInWithGoogle()}),
                 ),
                 SizedBox(height: 25,),
                AppleSignInButton(
                  cornerRadius: 25,
                  style: ButtonStyle.white, // style as needed
                  type: ButtonType.signIn, // style as needed
                  onPressed: () async {
                    await AppleSignIn.isAvailable().then((value) {
                      if (value) {
                        print("apple sign in available: ");
                        print(value.toString());
                        authService.signInWithApple(
                            scopes: [Scope.email, Scope.fullName]);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
