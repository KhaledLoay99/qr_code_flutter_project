import 'package:flutter/material.dart';
import 'package:qr_code_app/ui/signup.dart';
import './ui/login.dart';
import './ui/scanQr.dart';
import './ui/home.dart';
import './ui/profile.dart';
import './ui/carProfile.dart';

void main() {
  runApp(new MaterialApp(
    title: "Login App",
    //home: new Login(),
    //home: new Signup(),
    //home: new home(),
    home: new carProfile(),
  ));
}
