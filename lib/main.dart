import 'package:flutter/material.dart';
import 'package:qr_code_app/ui/signup.dart';
import './ui/login.dart';
import './ui/scanQr.dart';
import './ui/home.dart';

void main(){
  runApp(new MaterialApp(
    title: "Dcode App",
    //home: new Login(),
    home: new Signup(),
    //home: new home(),
    //home: new scanQr(),

  ));
}