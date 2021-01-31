import 'package:Dcode/logic/chatlist.dart';
import 'package:Dcode/logic/privatechat.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/login.dart';
import 'package:Dcode/ui/scanQr.dart';
import 'package:Dcode/ui/signup.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/ui/home.dart';

class privateChat extends StatefulWidget {
  @override
  var user;
  privateChat({var user}) {
    this.user = user;
  }
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return privateChatState();
  }
}

class privateChatState extends State<privateChat> {
  var _usernameField = new TextEditingController();

  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  final chatlistNames chatlistLogic = chatlistNames();
  final privatechat chatmsgs = privatechat();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle_rounded),
              new Text(chatlistLogic.getNames()[0]),
            ],
          ),
        ),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: Center(
                    child: Text(
                      chatmsgs.getMessages()[0].getText(),
                      textScaleFactor: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              new Text(
                chatmsgs.getMessages()[0].getTime(),
                textScaleFactor: 2,
                style: TextStyle(color: Colors.black26, fontSize: 7),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: Center(
                    child: Text(
                      chatmsgs.getMessages()[1].getText(),
                      textScaleFactor: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                ),
              ),
              new Text(
                chatmsgs.getMessages()[1].getTime(),
                textScaleFactor: 2,
                style: TextStyle(color: Colors.black26, fontSize: 7),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: Center(
                    child: Text(
                      chatmsgs.getMessages()[2].getText(),
                      textScaleFactor: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              new Text(
                chatmsgs.getMessages()[2].getTime(),
                textScaleFactor: 2,
                style: TextStyle(color: Colors.black26, fontSize: 7),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  height: 50,
                  //width: 250,
                  child: Center(
                    child: Text(
                      chatmsgs.getMessages()[3].getText(),
                      textScaleFactor: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                ),
              ),
              new Text(
                chatmsgs.getMessages()[3].getTime(),
                textScaleFactor: 2,
                style: TextStyle(color: Colors.black26, fontSize: 7),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.send),
                    hintText: 'Type . . .',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
