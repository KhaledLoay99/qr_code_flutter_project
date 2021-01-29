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
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          new Padding(padding: new EdgeInsets.all(30.0)),
          new Column(children: <Widget>[
            Text('Hello, $email'),
            new Padding(padding: new EdgeInsets.all(50.0)),

            new Row(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(30.0)),
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
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(50.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(8.0),
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
                              builder: (context) => SettingsPage()),
                        );
                      }, // When the child is tapped, make an action
                      child: new Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(50.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(8.0),
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
                        fontSize: 25.0,
                        fontFamily: 'Roboto',
                        color: new Color(0xFF26C6DA)),
                  ),
                ],
              ),
            ]),

            ////////////////////////////////////////////////////////////////////
            new Padding(padding: new EdgeInsets.all(40.0)),

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
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(50.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(8.0),
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
