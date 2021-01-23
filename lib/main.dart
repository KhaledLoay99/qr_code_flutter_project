import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ui/home.dart';
import 'ui/intro.dart';
import 'ui/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'MIUChat',
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              backgroundColor: Colors.lightBlue[200],
              accentColor: Colors.blueAccent,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
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
                        return home();
                      }
                      return intro();
                    }),
          );
        });
  }
}
