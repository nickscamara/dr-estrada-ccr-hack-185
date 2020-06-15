
import 'package:ccrhack/model/message.dart';
import 'package:ccrhack/services/create_acc_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatVirtual extends StatefulWidget {


  @override
  _ChatVirtualState createState() => _ChatVirtualState();
}

class _ChatVirtualState extends State<ChatVirtual> {
  
  TextEditingController textFieldController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool isWriting = false;
  
  
 
  @override
  void initState() { 
   
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
         actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CircleAvatar(
               radius: 20,
               backgroundImage: AssetImage("assets/img/assistente.jpg")),
           ),
          
        
         ],
         title: Text("Assistente de Saúde Virtual",style: TextStyle(color: Colors.white),),
         backgroundColor: Theme.of(context).primaryColor,
       ),
       
      body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),
          quickList(),
          chatControls(),
        ],
      ),
    );
  }
  Widget quickBtn(String text)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
                elevation: 0,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(.75),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                onPressed: (){
                  sendMessage(quick: true,txt: text);
                },
                child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
    );
  }

  Widget quickList()
  {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
             quickBtn("Estou cansado"),
             quickBtn("Marcar Consulta"),
             quickBtn("Dor nas Pernas"),
             quickBtn("Passar pela Triagem"),
             quickBtn("Dor de Cabeça"),
             quickBtn("SOS"),
          ],

        ),
      ),
    );
  }

  Widget messageList() {
    final accountService = Provider.of<ChatVirtualService>(context);
    return StreamBuilder<List<Message>>(
      stream: accountService.messagesList(),
      builder: (context, snapshot) {
        if(snapshot.data!=null )
        {
        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data[index]);
          },
        );
        }else
        {
          return Container();
        }
      }
    );
  }

  Widget chatMessageItem(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: message.id != "app"
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: message.id == "app"
            ? message.loading ? receiverLayout(message,message.loading) : receiverLayout(message,message.loading)
            : senderLayout(message),
      ),
    );
  }

  Widget senderLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 5),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color:Color(0xff00bbf0),
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child:  Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )
        ) 
      ),
    );
  }

  Widget receiverLayout(Message message, bool loading) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 5),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.75),
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child:loading == false ? Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ):  Lottie.asset('assets/img/loading_white.json',height: 25,width: 50),
      ),
    );
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    addMediaModal(context) {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content and tools",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ModalTile(
                        title: "Media",
                        subtitle: "Share Photos and Video",
                        icon: Icons.image,
                      ),
                      ModalTile(
                        title: "File",
                        subtitle: "Share files",
                        icon: Icons.tab),
                    ModalTile(
                        title: "Contact",
                        subtitle: "Share contacts",
                        icon: Icons.contacts),
                    ModalTile(
                        title: "Location",
                        subtitle: "Share a location",
                        icon: Icons.add_location),
                    ModalTile(
                        title: "Schedule Call",
                        subtitle: "Arrange a skype call and get reminders",
                        icon: Icons.schedule),
                    ModalTile(
                        title: "Create Poll",
                        subtitle: "Share polls",
                        icon: Icons.poll)
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return Container(
      padding: EdgeInsets.only(bottom:40,top:10,left:10,right: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add,color: Theme.of(context).primaryColor,),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              
              controller: textFieldController,
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                ),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.face,color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
         
          isWriting ? Container() : Container(width:50,child: Icon(Icons.camera_alt,color: Theme.of(context).primaryColor)),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                    onPressed: () => {
                      sendMessage()
                    },
                  ))
              : Container()
        ],
      ),
    );
  }

  sendMessage({bool quick = false, String txt = ""}){
    
    String text = !quick? textFieldController.text.trim() : txt.trim();
    final accountService = Provider.of<ChatVirtualService>(context,listen: false);
    accountService.sendMessage(new Message("medico",text,false));
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    textFieldController.clear();
  }



          

}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ModalTile({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.75),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}


class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget icon;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets margin;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  CustomTile({
    @required this.leading,
    @required this.title,
    this.icon,
    @required this.subtitle,
    this.trailing,
    this.margin = const EdgeInsets.all(0),
    this.onTap,
    this.onLongPress,
    this.mini = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 10 : 0),
        margin: margin,
        child: Row(
          children: <Widget>[
            leading,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: mini ? 10 : 15),
                padding: EdgeInsets.symmetric(vertical: mini ? 3 : 20),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            icon ?? Container(),
                            subtitle,
                          ],
                        )
                      ],
                    ),
                    trailing ?? Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}