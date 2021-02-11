import 'package:flutter/material.dart';
import 'package:Dcode/logic/carProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Carprovider with ChangeNotifier {
  Carprovider() {}
  List<Carprofile> car = [];
  bool prog = true;
  bool err = false;
  Future<void> updateData(String id, val) async {
    final userIndex = car.indexWhere((element) => element.id == id);
    var snaps = FirebaseFirestore.instance
        .collection('cars')
        .document(id)
        .updateData(val)
        .catchError((e) {});

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
          notifyListeners();
        });
      });
    } catch (error) {
      notifyListeners();
    }
  }
}
