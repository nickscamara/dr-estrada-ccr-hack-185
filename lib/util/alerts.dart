import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String desc) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK",style: TextStyle(color: Colors.red),),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    title: Text(title),
    content: Text(desc),
    actions: [
     // okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}