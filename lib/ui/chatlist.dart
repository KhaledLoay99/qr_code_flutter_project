import 'package:Dcode/logic/chatlist.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';
import 'notification.dart';
import 'profile.dart';
import 'dart:developer';

void main() => runApp(chatlist());

// #docregion MyApp
class chatlist extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chats',
      home: UserList(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class UserListState extends State<UserList> {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildChatList() {}
  // #enddocregion _buildSuggestions

  // #docregion _buildRow

  // #enddocregion _buildRow

  // #docregion RWS-build
  String loadAsset(String imagepath) {
    var imageUrl;
    try {
      var ref = FirebaseStorage.instance.ref().child(imagepath);
      ref.getDownloadURL().then((loc) {
        imageUrl = loc;
      });
    } catch (error) {
      imageUrl = null;
    }

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context); // avoid app from exiting
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Chats '),
              Image.asset(
                'images/chat.png',
                height: 40,
              ),
            ],
          ),
          backgroundColor: c1,
        ),
        backgroundColor: Colors.white,
        body: _buildChatList(),
      ),
    );
  }
// #enddocregion RWS-build
// #docregion RWS-var

}

// #enddocregion RWS-var
class UserList extends StatefulWidget {
  @override
  UserListState createState() => new UserListState();
}
