import 'package:Dcode/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/providers/Userprovider.dart';
import "package:provider/provider.dart";

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

  Widget _buildMessage(String message, bool isMe) {
    final msg = Container(
      width: 300,
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).accentColor
            : Color.fromRGBO(28, 160, 83, 1.0), //other user container color
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
        ],
      ),
    );

    if (isMe) return msg;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        msg,
        // IconButton(
        //   icon: Icon(
        //     true ? Icons.favorite : Icons.favorite_border_outlined,
        //     size: 30.0,
        //     color: true ? Theme.of(context).primaryColor : Colors.blueGrey,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = [currentUser, widget.user["userid"]];
    list.sort();
    Query users = FirebaseFirestore.instance
        .collection('messages')
        .where("userid1", isEqualTo: list[0])
        .where("userid2", isEqualTo: list[1])
        .orderBy('date');
    var imageUrl =
        "https://firebasestorage.googleapis.com/v0/b/dcode-bd3d1.appspot.com/o/user" +
            widget.user["userid"] +
            ".png?alt=media";
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
          final docs = snapshot.data.docs;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              title: Center(
                child: Row(
                  children: [
                    (imageUrl == null)
                        ? Image.asset('images/chat.png')
                        : Expanded(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                    Text(
                      widget.user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                // IconButton(
                //   icon: Icon(Icons.more_horiz, size: 30.0),
                //   onPressed: () {},
                // ),
                DropdownButton(
                    icon: Icon(
                      Icons.more_vert_outlined,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.account_circle_outlined),
                            SizedBox(
                              width: 8,
                            ),
                            Text(widget.user['username'] + ' Profile'),
                          ],
                        ),
                        value: 'userProfile',
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.directions_car),
                            SizedBox(
                              width: 8,
                            ),
                            Text(widget.user['username'] + ' Car Profile'),
                          ],
                        ),
                        value: 'carProfile',
                      )
                    ],
                    onChanged: (itemIdentifier) {
                      if (itemIdentifier == 'userProfile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<Userprovider>(
                                      create: (_) => Userprovider(),
                                      child: Profile(
                                          nUser: widget.user['userid']))),
                        );
                      }

                      if (itemIdentifier == 'carProfile') {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => home()),
                        // );
                      }
                    })
              ],
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.only(top: 15.0),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final bool isMe =
                                  currentUser == docs[index]['sentby'];
                              return _buildMessage(docs[index]['text'], isMe);
                            }),
                      ),
                    ),
                  ),
                  _buildMessageComposer(),
                ],
              ),
            ),
          );
        });
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
