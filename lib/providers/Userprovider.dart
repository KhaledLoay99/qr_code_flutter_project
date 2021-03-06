import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/logic/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Userprovider with ChangeNotifier {
  Userprovider() {}
  List<Userprofile> user = [];
  bool prog = true;
  bool err = false;
  Future<void> updateData(String id, val) async {
    final userIndex = user.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('users')
        .document(id)
        .updateData(val)
        .catchError((e) {});

    var nMap = Map<String, dynamic>.from(val);
    var data;
    for (final key in nMap.keys) {
      if (key == 'username') {
        user[userIndex].username = nMap[key];
        var mysnaps = FirebaseFirestore.instance
            .collection('users')
            .document(FirebaseAuth.instance.currentUser.uid);
        mysnaps.get().then((value) {
          value['chatlist'].forEach((users) {
            users['userid'];
            var csnaps = FirebaseFirestore.instance
                .collection('users')
                .document(users['userid'])
                .get()
                .then((cusers) {
              var chatList = cusers['chatlist'];
              chatList.forEach((chats) {
                if (chats['userid'] == FirebaseAuth.instance.currentUser.uid) {
                  chats['username'] = nMap[key];
                  data = chatList;
                  FirebaseFirestore.instance
                      .collection('users')
                      .document(users['userid'])
                      .updateData({'chatlist': data});
                }
              });
            });
          });
        });
        /*var xsnaps = FirebaseFirestore.instance.collection('users');
        xsnaps.snapshots().listen((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((document) {
            if (document.data()['chatlist'] != null) {
              var chatList = document.data()['chatlist'];
              chatList.forEach((element) {
                if (element['userid'] ==
                    FirebaseAuth.instance.currentUser.uid) {
                  element['username'] = nMap[key];
                  data = chatList;
                  xsnaps
                      .document(document.documentID)
                      .updateData({'chatlist': data});
                }
              });
            }
          });
          xsnaps.get().then((value) {});
        });*/
      }
      if (key == 'location') user[userIndex].location = nMap[key];
      if (key == 'profileImage') user[userIndex].profileImage = nMap[key];
      if (key == 'email') user[userIndex].email = nMap[key];
    }
    notifyListeners();
  }

  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      /*var xsnaps = FirebaseFirestore.instance.collection('users');
      List uname = [];
      int count = 0;
      xsnaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.documents.forEach((document) {
          if (document.data()['chatlist'] != null) count++;
          uname = document.data()['chatlist'];
        });
        xsnaps.get().then((value) {
          print(
              'KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKLKKKKKKKKKKKKKKKKKK');
          print(uname);
          uname.forEach((element) {
            print(element['userid']);
            if (element['userid'] == 'Uk8BJa6ipVXu4RLmZV85Yyc5naZ2')
              element['username'] = 'TEEEEST';
          });
          print(uname);
          print(count);
        });
      });*/
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.documents.forEach((document) async {
          user.add(Userprofile(
              id: document.documentID,
              email: await document.data()['email'],
              username: await document.data()['username'],
              location: await document.data()['location'],
              profileImage: await document.data()['profileImage'],
              qrImage: await document.data()['qrImage'],
              noOfChats: await document.data()['chatlist'] == null
                  ? 0
                  : document.data()['chatlist'].length));
        });
        snaps.get().then((value) {
          notifyListeners();
        });
      });
    } catch (error) {}
  }
}
