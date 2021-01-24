import 'dart:collection';
import 'dart:convert';
import 'package:Dcode/ui/chatlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Userprovider with ChangeNotifier {
  Userprovider() {
    fetchdata();
    //print(user);
  }
  List<Userprofile> user = [];
  bool prog = true;
  bool err = false;
  //var userTake = FirebaseAuth.instance.currentUser;
  //var user_id;
  Future<void> updateData(String id, val) async {
    //user_id = userTake.uid;
    final userIndex = user.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('users')
        .document(id)
        .updateData(val)
        .catchError((e) {
      print(e);
    });

    var nMap = Map<String, dynamic>.from(val);
    print(nMap);
    for (final key in nMap.keys) {
      if (key == 'username') user[userIndex].username = nMap[key];
      if (key == 'location') user[userIndex].location = nMap[key];
      if (key == 'profileImage') user[userIndex].profileImage = nMap[key];
      if (key == 'email') user[userIndex].email = nMap[key];
    }
    notifyListeners();
  }

  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    //var snaps = FirebaseFirestore.instance.collection('user');
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          querySnapshot.documents.forEach((document) {
            user.add(Userprofile(
              id: document.documentID,
              email: document.data()['email'],
              username: document.data()['username'],
              location: document.data()['location'],
              profileImage: document.data()['profileImage'],
              qrImage: document.data()['qrImage'],
            ));
          });
          snaps.get().then((value) {
            prog = false;
            notifyListeners();
          });
        } else {
          prog = false;
          err = true;
          notifyListeners();
        }
      });
    } catch (error) {
      prog = false;
      err = true;
      notifyListeners();
    }
  }
}
