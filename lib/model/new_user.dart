import 'package:ccrhack/model/resposta.dart';
import 'package:flutter/material.dart';

class NewUser {
  String email;
  String uid;
  List<Resposta> perguntas;
  NewUser({@required this.email, @required this.uid,this.perguntas});

  dynamic toMap()
  {
    List<Map<dynamic,dynamic>> respostas = [];
    for(var i = 0; i < perguntas.length; i++)
    {
      respostas.add({"id":int.parse(perguntas[i].id),"response":int.parse(perguntas[i].response)});
    }
    return {
      "userId": uid,
      "userEmail":email,
      "questions": respostas.toList(),
    };
  }

}
