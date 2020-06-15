import 'package:ccrhack/home.dart';
import 'package:ccrhack/model/new_user.dart';
import 'package:ccrhack/screens/auth/welcome_screen.dart';
import 'package:ccrhack/screens/new_user_form.dart';
import 'package:ccrhack/services/firebase_auth_service.dart';
import 'package:ccrhack/services/forms_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      final authProvider = Provider.of<FirebaseAuthService>(context);
      authProvider.signOut();
      try
      {
      NewUser newUser = NewUser(email: userSnapshot.data.email,uid: userSnapshot.data.uid);
      return userSnapshot.hasData ? NewUserForm(newUser) : OnBoardingScreen();

      }catch(e){}
      // NewUser user = NewUser(email: newUser.email, uid: newUser.uid);
      return OnBoardingScreen();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
