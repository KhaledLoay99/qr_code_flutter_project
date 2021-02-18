import 'package:Dcode/ui/auth_screen_signup.dart';
import 'package:flutter/material.dart';

import 'auth_screen_login.dart';

class intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome",
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
          backgroundColor: c1,
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                  ),
                  Image.asset(
                    'images/qrr.jpg',
                    fit: BoxFit.cover,
                    width: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthForm()),
                      );
                    },
                    child: Text("Sign UP".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side: BorderSide(color: Colors.cyan),
                    ),
                    color: Colors.cyan,
                    textColor: Colors.white,
                    minWidth: 200.0,
                    height: 50.0,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new Text("OR".toUpperCase(),
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthFormLogin()),
                      );
                    },
                    child: Text("Login".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side: BorderSide(color: Colors.cyan),
                    ),
                    color: Colors.cyan,
                    textColor: Colors.white,
                    minWidth: 200.0,
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        // body: Image.asset('images/qrr.jpg'), //   <-- image
      ),
    );
  }
}
