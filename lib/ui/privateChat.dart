import 'package:Dcode/ui/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dcode/ui/login.dart';
import 'package:Dcode/ui/scanQr.dart';
import 'package:Dcode/ui/signup.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/ui/home.dart';
class privateChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return privateChatState();
  }
}

class privateChatState extends State<privateChat> {
  Color c1 = const Color.fromRGBO(110,204,234,1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
    child: Row(
          children: <Widget>[
            Image.asset('images/chat.png', height: 40,),
            new Text(" Khaled Loay"),
          ],
        ),
        ),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: c1,

        onTap: (value) {
          // Respond to item press.
          if(value == 0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
            );
          }else if(value == 1){

            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => notify()),
             );
          }else if(value == 2){

//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => privatechat()),
//            );
          }else if(value == 3){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }

        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.home,color: Colors.black45,),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.notifications,color: Colors.black45,),
          ),
          BottomNavigationBarItem(
            title: Text('Recent Chats', style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.chat,color: Colors.white,),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            title: Text('My Profile', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.account_circle,color: Colors.black45,),

          ),
        ],
      ),

      body: Container(
        height: 600,
        width: 500,
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),

            new Padding(padding: const EdgeInsets.only(right: 100.0),

            child: Container(
              height: 50,
              width: 250,
              child: Center(
                child : Text(
                  'Hello, my friend',
                  textScaleFactor: 2,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
            ),
            ),

            new Text(
              'sent at: 3.00 PM',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black26, fontSize: 7),
            ),
            new Padding(padding: new EdgeInsets.all(20.0)),


            new Padding(padding: const EdgeInsets.only(left: 70.0),

              child: Container(
                height: 50,
                width: 250,
                child: Center(
                  child : Text(
                    'Hello, how are you man ?',
                    textScaleFactor: 2,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green,
                ),
              ),
            ),

            new Text(
              'sent at: 3.04 PM',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black26, fontSize: 7),
            ),




            new Padding(padding: new EdgeInsets.all(20.0)),


            new Padding(padding: const EdgeInsets.only(right: 100.0),

              child: Container(
                height: 50,
                width: 250,
                child: Center(
                  child : Text(
                    'I am fine thanks',
                    textScaleFactor: 2,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueAccent,
                ),
              ),
            ),

            new Text(
              'sent at: 3.04 PM',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black26, fontSize: 7),
            ),


            new Padding(padding: new EdgeInsets.all(20.0)),


            new Padding(padding: const EdgeInsets.only(left: 70.0),

              child: Container(
                height: 50,
                //width: 250,
                child: Center(
                  child : Text(
                    'What is the lecture time !?',
                    textScaleFactor: 2,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green,
                ),
              ),
            ),

            new Text(
              'sent at: 3.05 PM',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black26, fontSize: 7),
            ),

            new Padding(padding: new EdgeInsets.all(20.0)),
            Form(
              key: _formKey,
              child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.send),
                hintText: 'Type . . .',
                border: const OutlineInputBorder(),
              ),
            ),
            ),
          ],
        ),
      ),

    );
  }
}