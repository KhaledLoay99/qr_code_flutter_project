import 'package:Dcode/logic/notifications.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'profile.dart';

class notify extends StatefulWidget {
  @override
  _notifyState createState() => _notifyState();
}

class _notifyState extends State<notify> with TickerProviderStateMixin {
  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final notifylogic Notification = notifylogic();
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..repeat();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: c1,
        title: Row(
          children: <Widget>[
            Text('Notification'),
            RotationTransition(
              turns: Tween(begin: 0.0, end: -.1)
                  .chain(CurveTween(curve: Curves.elasticIn))
                  .animate(_animationController),
              child: Badge(
                badgeContent: Text('3', style: TextStyle(color: Colors.white)),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
//          title: new Text("Login"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: c1,
        onTap: (value) {
          // Respond to item press.
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
            );
          } else if (value == 1) {
//            Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => notify()),
//             );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatlist()),
            );
          } else if (value == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black45),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.black45,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
              title: Text(
                'Recent Chats',
                style: TextStyle(color: Colors.black45),
              ),
              icon: Icon(
                Icons.chat,
                color: Colors.black45,
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.black45),
            ),
            icon: Icon(
              Icons.account_circle,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      body: Center(
        child: new ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Conversations',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Futura',
                          color: Colors.black,
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Notification.getmsgs().keys.toList()[0],
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        Notification.get_qrImage,
                        fit: BoxFit.cover,
                        width: 25,
                      ),
                      Text(
                        Notification.getmsgs().values.toList()[0],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.circle),
                        color: Colors.red,
                        iconSize: 15,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => privateChat()),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Purchasers',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Futura',
                          color: Colors.black,
                          height: 3,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Notification.getpurchasers().keys.toList()[0],
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        Notification.get_qrImage,
                        fit: BoxFit.cover,
                        width: 25,
                      ),
                      Text(
                        Notification.getpurchasers().values.toList()[0],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Notification.getpurchasers().keys.toList()[1],
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        Notification.get_qrImage,
                        fit: BoxFit.cover,
                        width: 25,
                      ),
                      Text(
                        Notification.getpurchasers().values.toList()[1],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Futura',
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
