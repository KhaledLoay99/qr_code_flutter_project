import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  var user;
  ChatScreen({var user}) {
    this.user = user;
  }

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = new ScrollController();

  var _messagefield = new TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser.uid;
  Widget _buildMessageComposer() {
    return Container(
      height: 70.0,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messagefield,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: "Send a message ...",
              border: InputBorder.none,
            ),
          )),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            iconSize: 25.0,
            onPressed: () {
              if (_messagefield.text != "") {
                sendMessage(
                    currentUser, widget.user["userid"], _messagefield.text);
                _messagefield.text = "";
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
                // FocusScope.of(context).unfocus();
              }
              Future.delayed(Duration(microseconds: 500), () {
                //FocusScope.of(context).unfocus();
                //call back after 500  microseconds
              });
              //FocusScope.of(context).unfocus();
              // FocusScopeNode currentFocus = FocusScope.of(context);
              // if (!currentFocus.hasPrimaryFocus) {
              //   currentFocus.unfocus();
              // }
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(String myid, String userid, String text) async {
    await Firebase.initializeApp();
    var list = [myid, userid];
    list.sort();
    Map<String, dynamic> messageInfo = {
      'date': FieldValue.serverTimestamp(),
      'sentby': myid,
      'text': text,
      "userid1": list[0],
      'userid2': list[1]
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('messages');
    collectionReference.add(messageInfo);
  }
}
