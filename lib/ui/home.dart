import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:Dcode/ui/scanQr.dart';

import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/providers/Userprovider.dart';
import "package:provider/provider.dart";
import 'package:Dcode/providers/Carprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<home> {
  var user = FirebaseAuth.instance.currentUser;
  var name, email, photoUrl, uid, emailVerified;

  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");
  void initState() {
    // initialzing the push notification stuffs

    final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
    // firebase messaging on receiving from the push notifications start - Naveen
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        // when app is terminated or not running
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (_) => chatlist()));
      },
      onResume: (Map<String, dynamic> msg) {
        // when app is running in background
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (_) => chatlist()));
      },
      onMessage: (Map<String, dynamic> msg) {
        // when app is running on foreground
        /*navigatorKey.currentState
            .push(MaterialPageRoute(builder: (_) => chatlist()));*/
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      email = user.email;
      uid = user.uid;
    }
    return new MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Container(
            decoration: BoxDecoration(
              color: c1,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
              ),
            ),
            child: ListView(
              children: [
                new Padding(padding: new EdgeInsets.all(10.0)),
                Center(
                  child: Text(
                    'Welcome ,\n ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    '$email',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            new Column(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(50.0)),

              new Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Column(
                  children: [
                    new Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => scanQr()),
                          );
                        }, // When the child is tapped, make an action
                        child: new Container(
                          width: 130,
                          height: 130,
                          padding: EdgeInsets.all(50.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                              image: new DecorationImage(
                                image: new AssetImage("images/qr-code.png"),
                                fit: BoxFit.fill,
                              )),
                          //child: Text('My Button'),
                        ),
                      ),
                    ),
                    new Text(
                      'Scan',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF26C6DA)),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.all(30.0)),
                Column(
                  children: [
                    new Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<Userprovider>(
                                        create: (_) => Userprovider(),
                                        child: SettingsPage())),
                          );
                        }, // When the child is tapped, make an action
                        child: new Container(
                          width: 130,
                          height: 130,
                          padding: EdgeInsets.all(50.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                              image: new DecorationImage(
                                image: new AssetImage("images/settings.png"),
                                fit: BoxFit.fill,
                              )),
                          //child: Text('My Button'),
                        ),
                      ),
                    ),
                    new Text(
                      'Settings',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF26C6DA)),
                    ),
                  ],
                ),
              ]),

              ////////////////////////////////////////////////////////////////////
              new Padding(padding: new EdgeInsets.all(30.0)),

              new Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<Carprovider>(
                                  create: (_) => Carprovider(),
                                  child: carProfile())),
                    );
                  }, // When the child is tapped, make an action
                  child: new Container(
                    width: 130,
                    height: 130,
                    padding: EdgeInsets.all(50.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        image: new DecorationImage(
                          image: new AssetImage("images/background.png"),
                          fit: BoxFit.fill,
                        )),
                    //child: Text('My Button'),
                  ),
                ),
              ),
              new Text(
                'Car Information',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Roboto',
                    color: new Color(0xFF26C6DA)),
              ),
            ]),
          ],
        ),
      ),
    );
    // TODO: implement build
  }
}
