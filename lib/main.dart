import 'package:ccrhack/auth_widget.dart';
import 'package:ccrhack/auth_widget_builder.dart';
import 'package:ccrhack/services/create_acc_service.dart';
import 'package:ccrhack/services/firebase_auth_service.dart';
import 'package:ccrhack/services/forms_service.dart';
import 'package:ccrhack/services/image_picker_service.dart';
import 'package:ccrhack/theme/theme.dart';
import 'package:ccrhack/widgets/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        ChangeNotifierProvider<FormsService>(
          create: (_) => FormsService(),
        ),
        ChangeNotifierProvider<ChatVirtualService>(
          create: (_) => ChatVirtualService(),
        ),
         
         
        ],
        child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SPAITR',
          theme: appTheme,
          home: AuthWidget(userSnapshot: userSnapshot),
        );
      }),
      
    );
  }
}