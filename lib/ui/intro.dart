import 'package:flutter/material.dart';


class intro extends StatelessWidget {
@override
  Widget build(BuildContext context) {
      Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0);
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
        title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),

        backgroundColor: c1,
      ),
      body: Container(child: Column(
children: [
  Image.asset('images/qrr.jpg'),
//   OutlineButton(
//     color: Colors.cyan,
//   child: new Text("Button text"),
//   onPressed: (){},
  
//   borderSide: BorderSide( color: Colors.cyan, //Color of the border
//             style: BorderStyle.solid, //Style of the border
//             width: 25, ),
//   shape: new RoundedRectangleBorder(
//     borderRadius: new BorderRadius.circular(100.0)),
            
// //  shape: CircleBorder(),
// //             borderSide: BorderSide(
// //               color: Colors.blue,
// //               style: BorderStyle.solid,
// //               width: 50,
// // )
//   ),
FlatButton(
onPressed: (){}, 
child: 
Text("Sign UP".toUpperCase(),
        style: TextStyle(fontSize: 14)),

shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(100.0),
  side: BorderSide(color: Colors.cyan),
  
),
 color: Colors.cyan,
      textColor: Colors.white,
      minWidth: 200.0,
  height: 50.0,

),
SizedBox(height: 30,),
  new Text("OR".toUpperCase(),
        style: TextStyle(fontSize: 14,
        color: Colors.grey)
       

        ),

SizedBox(height: 30,),

        FlatButton(
onPressed: (){}, 
child: 
Text("Login".toUpperCase(),
        style: TextStyle(fontSize: 14)),

shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(100.0),
  side: BorderSide(color: Colors.cyan),
  
),
 color: Colors.cyan,
      textColor: Colors.white,
      minWidth: 200.0,
  height: 50.0,

),
],


      ) 
      ,),
        // body: Image.asset('images/qrr.jpg'), //   <-- image
      ),
    );
  }
}