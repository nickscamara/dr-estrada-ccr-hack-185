import 'package:ccrhack/model/pergunta.dart';
import 'package:flutter/material.dart';

class FormsService with ChangeNotifier {
  int currentIndex = 0;

  List<String> textNovoUser1 = [
    "Olá, meu nome é Tião e sou seu assistente de saúde virtual.",
    "Você sabia que mais 1 em cada 3 caminhoneiros tem um problema de saúde que precisa de cuidados médicos mas boa parte deles nem sabe do problema?",
    "Me diz uma coisa:",
  ];
  List<String> textNovoUser2 = [
    """A CCR oferece alguns postos de atendimento para te ajudar a cuidar da sua saúde: veja se vai passar por algum desses endereços e venha nos visitar."""
  ];
  List<Pergunta> perguntasNovoUser = [
    new Pergunta(
        "1",
        "Você está sentindo alguma coisa no momento (febre alta, dor no peito, falta de ar?)",
        ["Sim", "Não"]),
    new Pergunta(
        "2",
        "Você tem algum problema de saúde ou toma algum medidamento todos os dias?",
        ["Sim", "Não"]),
    new Pergunta("3", "Quando foi a última vez que foi ao médico?",
        ["Há menos de 6 meses", "Entre 6 meses e um ano", "Há mais de um ano"]),
    new Pergunta(
        "4",
        "Você gostaria de marcar uma consulta (grátis) por telefone com um médico especialista em saúde do caminhoneiro?",
        ["Sim", "Não"]),
    new Pergunta(
        "5",
        "Entendo que esteja sem tempo agora. Quer ajuda para se lembrar de marcar sua consulta",
        ["Sim", "Não"])
  ];
  int getMaxIndexNovoUser() {
    return perguntasNovoUser.length;
  }

  String getNextQuestion() {
    print("index: " + currentIndex.toString());
    return perguntasNovoUser[currentIndex].pergunta;
  }

  void increaseIndex() {
    currentIndex++;
    notifyListeners();
  }

  void decreaseIndex() {
    currentIndex--;
    notifyListeners();
  }
}
