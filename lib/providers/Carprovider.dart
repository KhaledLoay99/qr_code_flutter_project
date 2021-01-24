import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/carProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Carprovider with ChangeNotifier {
  Carprovider() {
    //fetchdata();
  }
  List<Carprofile> car = [];
  bool prog = true;
  bool err = false;
  Future<void> updateData(String id, val) async {
    //put line 18 here as example to intialize the user_id
    final userIndex = car.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('cars')
        .document(id)
        .updateData(val)
        .catchError((e) {
      print(e);
    });

    var nMap = Map<String, dynamic>.from(val);
    print(nMap);
    for (final key in nMap.keys) {
      if (key == 'carModel') car[userIndex].carmodel = nMap[key];
      if (key == 'SaleStatus') car[userIndex].salestatus = nMap[key];
      if (key == 'Location') car[userIndex].location = nMap[key];
      if (key == 'CarProfileImage') car[userIndex].carprofileImage = nMap[key];
    }
    notifyListeners();
  }

  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('cars');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          querySnapshot.documents.forEach((document) async {
            car.add(Carprofile(
              id: await document.documentID,
              userid: await document.data()['userid'],
              location: await document.data()['Location'],
              salestatus: await document.data()['SaleStatus'],
              carmodel: await document.data()['carModel'],
              carprofileImage: await document.data()['CarProfileImage'],
            ));
          });
          snaps.get().then((value) {
            //prog = false;
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
