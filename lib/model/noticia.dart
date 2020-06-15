class Noticia{
  String title;
  String date;
  String description;
  String link;

  Noticia({this.date,this.title,this.description,this.link});

  static Noticia fromMap(Map<dynamic,dynamic> map)
  {
    return new Noticia(
      title:map["title"],
      date:map["date"],
      description:map["description"],
      link:map["link"]
    );

  }

  
}