import 'package:Dcode/logic/chatlist.dart';
import 'package:Dcode/logic/privatechat.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/login.dart';
import 'package:Dcode/ui/scanQr.dart';
import 'package:Dcode/ui/signup.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/ui/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

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

  Widget chat() {
    var currentUser = FirebaseAuth.instance.currentUser.uid;
    var list = [currentUser, widget.user["userid"]];

    list.sort();
    Query users = FirebaseFirestore.instance
        .collection('messages')
        .where("userid1", isEqualTo: list[0])
        .where("userid2", isEqualTo: list[1])
        .orderBy('date');
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Container();
          }
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
        });
  }
}
