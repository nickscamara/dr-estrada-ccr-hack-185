import 'dart:convert';

import 'package:ccrhack/model/new_user.dart';
import 'package:ccrhack/model/noticia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String uid;
  ApiService({@required this.uid});
  final String noticiaURL =
      "https://nd0a16wdpf.execute-api.sa-east-1.amazonaws.com/dev/ccr/news";
  final String restURL =
      'https://nd0a16wdpf.execute-api.sa-east-1.amazonaws.com/dev/form';

  Future<List<Noticia>> noticiasCCR() async {
    var response = await http.get(noticiaURL,headers:{
      "charset":"utf-8"
    });
    final decoded = utf8.decode(response.bodyBytes);
    final decodedJSON = json.decode(decoded);
    List<Noticia> noticias = [];
    for(var i in decodedJSON["items"])
    {
      noticias.add( Noticia.fromMap(i));
    }
    return noticias;
  }

  Future<String> salvaDB(NewUser newUser) async {
    var response = await http.post(restURL,
        headers: {"content-type": "application/json"},
        body: jsonEncode(newUser.toMap()));
    return response.body.toString();
  }

  Future<void> createAccount(String first, String last, String dob,
      String username, String referredBy, String email, String uid) async {
    var response = await http.post(restURL + "pf/createaccount", body: {
      'first': first,
      'last': last,
      'dob': dob,
      'email': email,
      'username': "password",
      'uid': "awdwada",
      "referredBy": "awdawd",
    });
    print(response.body);
  }
}
