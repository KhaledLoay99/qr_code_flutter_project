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
              Image.network(
                widget.user['imagepath'],
                width: 50,
                height: 50,
              ),
              new Text(widget.user['username']),
            ],
          ),
        ),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      body: chat(),
    );
  }

  Widget chat() {}
}
