import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Dcode/logic/carProfile.dart';

class Carprovider with ChangeNotifier {
  Carprovider() {
    fetchdata();
    //print(user);
  }
  List<Carprofile> user = [];
  bool prog = true;
  bool err = false;
  Future<void> fetchdata() async {
    const url = "https://dcode-bd3d1-default-rtdb.firebaseio.com/Car.json";
    try {
      final http.Response res = await http.get(url);
      /*http.post(url,
          body: json.encode({
            "CarModel": "Nissan Sunny ",
            "SaleStatus": "true",
            "Location": "Misr el jadidah",
            "PhoneNumber": "Lewandowski",
            "CarProfileImage": "images/profile.jpg",
            "Owner": "RL9@gmail.com"
          }));*/
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((carid, carData) {
        user.add(Carprofile(
            id: carid,
            carmodel: carData['CarModel'],
            salestatus: carData['SaleStatus'] == "true" ? true : false,
            location: carData['Location'],
            phonenumber: carData['PhoneNumber'],
            carprofileImage: carData['CarProfileImage'],
            owner: carData['Owner']));
      });
      prog = false;
      notifyListeners();
    } catch (error) {
      prog = false;
      err = true;
      notifyListeners();
      //throw error;
    }
  }
}
