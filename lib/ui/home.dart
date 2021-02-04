import 'package:Dcode/ui/navigatorBar.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:Dcode/ui/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/scanQr.dart';
import 'package:Dcode/ui/intro.dart';

import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/providers/Userprovider.dart';
import "package:provider/provider.dart";
import 'package:Dcode/providers/Carprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chatlist.dart';
import 'intro.dart';

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
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      email = user.email;
      uid = user.uid;
    }

    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          new Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: c1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    new Padding(padding: new EdgeInsets.all(8.0)),
                    Text(
                      'Welcome ,\n ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Expanded(
                      child: Text(
                        '$email',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Padding(padding: new EdgeInsets.all(50.0)),

            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
    );
  }
}
