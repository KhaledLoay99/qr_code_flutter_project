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
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/providers/Carprovider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
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
                _scrollController
                    .jumpTo(_scrollController.position.minScrollExtent);

                // FocusScope.of(context).unfocus();
              }
              //FocusScope.of(context).unfocus();
              //call back after 500  microseconds

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

  Widget _buildMessage(String message, bool isMe, String time) {
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
          SizedBox(height: 8.0),
          Text(time,
              style: TextStyle(
                fontSize: 10.0,
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
            //backgroundColor: c1,
            appBar: AppBar(
              backgroundColor: c1,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              title: Row(
                children: [
                  (imageUrl == null)
                      ? Image.asset('images/chat.png')
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.fill),
                          ),
                        ),
                  Flexible(
                    child: Text(
                      ' ' + widget.user['username'],
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<Carprovider>(
                                      create: (_) => Carprovider(),
                                      child: carProfile(
                                          nUser: widget.user['userid']))),
                        );
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
                        // borderRadius: BorderRadius.only(
                        //   topRight: Radius.circular(80.0),
                        //   topLeft: Radius.circular(80.0),
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.only(top: 15.0),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              String timeString =
                                  docs[(docs.length - 1) - index]['date']
                                      .toDate()
                                      .toString();
                              DateTime date = DateTime.parse(timeString);
                              String time =
                                  DateFormat('hh:mm a').format(date).toString();

                              //log(DateFormat('hh:mm').format(date));

                              final bool isMe = currentUser ==
                                  docs[(docs.length - 1) - index]['sentby'];
                              return _buildMessage(
                                  docs[(docs.length - 1) - index]['text'],
                                  isMe,
                                  time);
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
