import 'package:ccrhack/home.dart';
import 'package:ccrhack/model/new_user.dart';
import 'package:ccrhack/model/resposta.dart';
import 'package:ccrhack/services/api_service.dart';
import 'package:ccrhack/services/firebase_auth_service.dart';
import 'package:ccrhack/services/forms_service.dart';
import 'package:ccrhack/util/typewriter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NewUserForm extends StatefulWidget {
  final NewUser newUser;
  NewUserForm(this.newUser);
  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {

  List<Resposta> respostas = [];
  bool introduction = false;
  @override
  Widget build(BuildContext context) {
    final formsService = Provider.of<FormsService>(context, listen: true);
    //final authService = Provider.of<FirebaseAuthService>(context, listen: true);
    //authService.signOut();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Consumer<FormsService>(
          builder: (context, value, child) {
            return Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.025),
                              offset: Offset(0, 10),
                              blurRadius: 5,
                              spreadRadius: .5),
                        ],
                      ),
                      child: SizedBox(
                        width: 300.0,
                        child: Text(
                          value.getNextQuestion(),
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        // child: TypewriterAnimatedTextKit(
                        //   isRepeatingAnimation: false,
                        //     onFinished: () {
                        //       print("awda");
                        //     },
                        //     speed: Duration(milliseconds: 10),
                        //     onTap: () {
                        //       print("Tap Event");
                        //     },
                        //     text: [
                        //      value.getNextQuestion()
                        //     ],
                        //     textStyle:
                        //         TextStyle(fontSize: 20.0, color: Colors.white),
                        //     textAlign: TextAlign.start,
                        //     alignment: AlignmentDirectional
                        //         .topStart // or Alignment.topLeft
                        //     ),
                      ),
                    ),
                    SizedBox(height: 25),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: formsService
                          .perguntasNovoUser[formsService.currentIndex]
                          .respostas
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 8, top: 8),
                          child: ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            buttonColor: Colors.white,
                            child: RaisedButton(
                              splashColor:
                                  Theme.of(context).secondaryHeaderColor,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                  formsService
                                      .perguntasNovoUser[
                                          formsService.currentIndex]
                                      .respostas[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context).primaryColor)),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                controllerPergunta(context,index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Lottie.asset("assets/img/personagem.json",
                        animate: true, repeat: true),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  controllerPergunta(context,indexClicado) async {
    print(indexClicado);
    final formsService = Provider.of<FormsService>(context, listen: false);
     final apiService = Provider.of<ApiService>(context, listen: false);
    int maxlen = formsService.getMaxIndexNovoUser() - 1;
    respostas.add(new Resposta(formsService.perguntasNovoUser[formsService.currentIndex].id.toString(),indexClicado.toString()));
    if (maxlen > formsService.currentIndex) {
      formsService.increaseIndex();
    }else{
      widget.newUser.perguntas = respostas;
      final statusCode = await apiService.salvaDB(widget.newUser);
      print(statusCode);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Home()));
    }
    setState(() {});
  }
}
