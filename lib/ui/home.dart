import 'package:flutter/material.dart';
import 'package:qr_code_app/ui/scanQr.dart';

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
        type: BottomNavigationBarType.fixed,
        backgroundColor: c1,
        selectedItemColor: Colors.white,
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

      body: new Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.all(50.0)),

    new Row(children: <Widget>[
      new Padding(padding: new EdgeInsets.all(30.0)),

    new Container(

      child:GestureDetector(
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => scanQr()),
                );
            },   // When the child is tapped, make an action
            child: new Container(
              width: 100 ,
              height: 100,
              padding: EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(8.0),
                  image: new DecorationImage(
                    image: new AssetImage("images/qr-code.png"),
                    fit: BoxFit.fill,
                  )
              ),
              //child: Text('My Button'),
            ),

          ),


    ),



      new Padding(padding: new EdgeInsets.all(30.0)),
        GestureDetector(
          onTap: () {}, // When the child is tapped, make an action
          child: new Container(
            width: 100 ,
            height: 100,
            padding: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
              borderRadius: BorderRadius.circular(8.0),
                image: new DecorationImage(
                  image: new AssetImage("images/settings.png"),
                  fit: BoxFit.fill,
                )
            ),
            //child: Text('My Button'),
          ),
        ),
    ]),
          new Text(
            'Scan               '
                'Settings',
            style: new TextStyle(
                fontSize: 25.0,
                fontFamily: 'Roboto',
                color: new Color(0xFF26C6DA)
            ),
          ),

          new Padding(padding: new EdgeInsets.all(40.0)),
//////////////////////////////////////////////////////////////////////////////////////////
          new Row(children: <Widget>[
            new Padding(padding: new EdgeInsets.all(30.0)),

    GestureDetector(
            onTap: () {},   // When the child is tapped, make an action
                child: new Container(
                  width: 100 ,
                  height: 100,
                padding: EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.circular(8.0),
                    image: new DecorationImage(
                      image: new AssetImage("images/history.png"),
                      fit: BoxFit.fill,
                    )
                ),

                  //child: Text('My Button'),

                ),
    ),


            new Padding(padding: new EdgeInsets.all(30.0)),
            GestureDetector(
              onTap: () {},  // When the child is tapped, make an action

              child :new Container(
                width: 100 ,
                height: 100,
                padding: EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(8.0),
                    image: new DecorationImage(
                      image: new AssetImage("images/packard-bell.png"),
                      fit: BoxFit.fill,
                    )
                ),
                //child: Text('My Button'),
              ),
            ),
          ]),
          new Text(
            'Recent Chats    '
                'Notifications',
            style: new TextStyle(
                fontSize: 25.0,
                fontFamily: 'Roboto',
                color: new Color(0xFF26C6DA)
            ),
          ),
          ////////////////////////////////////////////////////////////////////
          new Padding(padding: new EdgeInsets.all(30.0)),

    GestureDetector(
             onTap: () {},    // When the child is tapped, make an action

        child :new Container(
          width: 100 ,
          height: 100,
              padding: EdgeInsets.all(50.0),
               decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(8.0),
                   image: new DecorationImage(
                     image: new AssetImage("images/background.png"),
                     fit: BoxFit.fill,
                   )
                ),
        //child: Text('My Button'),
    ),
    ),
          new Text(
            'Check Car Information',
            style: new TextStyle(
                fontSize: 25.0,
                fontFamily: 'Roboto',
                color: new Color(0xFF26C6DA)
            ),
          ),

        ]
      ),
    );
  }
}