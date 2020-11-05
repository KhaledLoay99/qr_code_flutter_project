import 'package:flutter/material.dart';

class scanQr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return scanQrState();
  }
}

class scanQrState extends State<scanQr> {
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: c1,
        selectedItemColor: Colors.black45,
//        unselectedItemColor: Colors.white.withOpacity(.60),
//        selectedFontSize: 14,
//        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications'),
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            title: Text('Recent Chats'),
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            title: Text('My Profile'),
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),

      body:new Container(

        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[

            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Scan New Qr", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.blue),),
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(8.0),
                  image: new DecorationImage(
                    image: new AssetImage("images/qr-code.png"),
                    fit: BoxFit.fill,
                  )
              ),
            ),

            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Click below Camer Button To Scan", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
            new Padding(padding: new EdgeInsets.all(20.0)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.lightBlue,
      ),

    );
  }
}