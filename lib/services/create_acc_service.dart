import 'package:ccrhack/model/message.dart';
import 'package:flutter/material.dart';

class ChatVirtualService extends ChangeNotifier{
  int currentIndex = 0;
  Map<int, List<String>> createStrings = {
    0: ["Oi Ricardo!,",
    "Sou Eduardo, e estou aqui pra te ajudar",
    "O que te traz aqui?",
    ],
    1: ["Entendi!",
    "Bom, vi aqui que você ja efetuou uma triagem inicial com a gente.",
    "Gostaria de prosseguir pra uma consulta?",
    ],
    2: ["Perfeito!",
    "Vou te redirecionar pro link da cia da consulta",
    "Um jeito fácil de te conectar com um médico",
    ]

  };

  List<Message> messages = [
    //new Message("app","Oi, tudo bem",false),
    //new Message("app","",true)
  ];
  List<String> userInput = [];
  
  Stream<List<Message>> messagesList() async*
  {
   // if(currentIndex == -1){sendMessage(new Message("first", "", false));currentIndex++;}
    var interval  = Duration(milliseconds: 500);
    await Future.delayed(interval);
    yield messages;
  }
  void sendAppMessage() async
  {
    print(messages.last.id );
    if(messages.last.id != "app")
    {
      for(var i = 0; i < createStrings[currentIndex].length; i++)
      {
      var interval  = Duration(milliseconds: 1500);
      messages.add(new Message("app","",true));
      await Future.delayed(interval);
      messages.removeLast();
      messages.add(new Message("app",createStrings[currentIndex][i],false));
      notifyListeners();

      }
     
      currentIndex++;
    }
    else
    {
      processMsg(messages.last);
    }

  }
  void processMsg(Message message)
  {
    print("processing");
  }
  void sendMessage(Message message)
  {
    messages.add(message);
    sendAppMessage();
    notifyListeners();
  }
  void addIndex()
  {
    currentIndex++;
    notifyListeners();

  }

}