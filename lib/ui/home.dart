import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<home> {
  Color c1 = const Color.fromRGBO(110,204,234,1.0); // fully transparent white (invisible)

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
        backgroundColor: c1,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('My Notifications'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              title: Text('Recent Chats')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('My Profile')
          )
        ],
      ),
      body: new Container(),
    );
  }
}