import 'package:ccrhack/model/noticia.dart';
import 'package:ccrhack/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
         leading: Container(),
        title: Text(
          "Notícias | CCR AUTOBAN",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<Noticia>>(
            future: apiService.noticiasCCR(),
            builder: (context, snapshot) {
              if (snapshot.data != null &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Noticia noticia = snapshot.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              )
                            ],
                          ),
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              highlightColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                              focusColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                              splashColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                              onTap: () async {
                                await _launchURL(
                                    "https://ciadaconsulta.com.br/ccr");
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     boxShadow: [
                                //       BoxShadow(
                                //           color: Colors.black.withOpacity(.025),
                                //           offset: Offset(0, 10),
                                //           blurRadius: 5,
                                //           spreadRadius: .5),
                                //     ],
                                //     borderRadius: BorderRadius.circular(15)),
                                child: ListTile(
                                  onTap: () => _launchURL(noticia.link),
                                  title: Text(
                                    noticia.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        noticia.description,
                                      ),
                                      Text(
                                        noticia.date,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
