import 'package:Dcode/ui/navigatorBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ui/intro.dart';
import 'ui/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() => runApp(
      MyApp(),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(), // Wrap your app
      // ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'Dcode App',
            debugShowCheckedModeBanner: false,
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }

                      if (userSnapshot.hasData) {
                        return HomePage('');
                      }
                      return intro();
                    }),
          );
        });
  }
}
