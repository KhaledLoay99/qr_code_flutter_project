import 'package:flutter/material.dart';
import 'package:qr_code_app/ui/signup.dart';
import './ui/login.dart';

void main(){
  runApp(new MaterialApp(
    title: "Login App",
    home: new Login(),
    //home: new Signup(),
  ));
}