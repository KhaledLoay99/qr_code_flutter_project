import 'package:Dcode/ui/notification.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:Dcode/ui/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/login.dart';
import 'package:Dcode/ui/scanQr.dart';
import 'package:Dcode/ui/signup.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/providers/Userprovider.dart';
import "package:provider/provider.dart";

import 'chatlist.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<home> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: c1,
        onTap: (value) {
          // Respond to item press.
          if (value == 0) {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => home()),
//            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => notify()),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatlist()),
            );
          } else if (value == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<Userprovider>(
                      create: (_) => Userprovider(), child: Profile())),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.black45),
            ),
            icon: Icon(
              Icons.notifications,
              color: Colors.black45,
            ),
          ),
          BottomNavigationBarItem(
              title: Text(
                'Recent Chats',
                style: TextStyle(color: Colors.black45),
              ),
              icon: Icon(
                Icons.chat,
                color: Colors.black45,
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.black45),
            ),
            icon: Icon(
              Icons.account_circle,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          new Column(children: <Widget>[
            new Padding(padding: new EdgeInsets.all(50.0)),

            new Row(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(30.0)),
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
              new Padding(padding: new EdgeInsets.all(30.0)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
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
            ]),
            new Text(
              'Scan               '
              'Settings',
              style: new TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF26C6DA)),
            ),

            new Padding(padding: new EdgeInsets.all(20.0)),
//////////////////////////////////////////////////////////////////////////////////////////
            new Row(children: <Widget>[
              new Padding(padding: new EdgeInsets.all(30.0)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chatlist()),
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
                        image: new AssetImage("images/history.png"),
                        fit: BoxFit.fill,
                      )),

                  //child: Text('My Button'),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(30.0)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => notify()),
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
                        image: new AssetImage("images/packard-bell.png"),
                        fit: BoxFit.fill,
                      )),
                  //child: Text('My Button'),
                ),
              ),
            ]),
            new Text(
              'Recent Chats    '
              'Notifications',
              style: new TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Roboto',
                  color: new Color(0xFF26C6DA)),
            ),
            ////////////////////////////////////////////////////////////////////
            new Padding(padding: new EdgeInsets.all(20.0)),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => carProfile()),
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
            new Text(
              'Check Car Information',
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
