import 'package:flutter/material.dart';
import 'package:Dcode/ui/signup.dart';
import './ui/login.dart';
import './ui/scanQr.dart';
import './ui/home.dart';
import './ui/profile.dart';
import './ui/carProfile.dart';
import 'ui/settings.dart';

void main() {
  runApp(new MaterialApp(
    title: "Dcode App",
    //home: new Login(),
    home: new Settings(),
    //home: new home(),
    //home: new scanQr(),
  ));
}
