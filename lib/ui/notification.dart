import 'package:Dcode/logic/notifications.dart';
import 'package:Dcode/providers/Carprovider.dart';
import 'package:Dcode/providers/Userprovider.dart';
import 'package:Dcode/ui/carProfile.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
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
  final _biggerFont = const TextStyle(fontSize: 18.0);

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

  Widget _buildChatList() {
    var imageUrl;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.active) {
          var courseDocument = snapshot.data.data;
          var sections = courseDocument()['chatlist'];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, index) {
              imageUrl =
                  "https://firebasestorage.googleapis.com/v0/b/dcode-bd3d1.appspot.com/o/user" +
                      sections[index]['userid'] +
                      ".png?alt=media";
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Row(
                      children: <Widget>[
                        (imageUrl == null)
                            ? Image.asset('images/chat.png')
                            : Expanded(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  title: Text(
                    sections[index]['username'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Scanned At: ",
                  ),

                  trailing: Icon(Icons.access_time_sharp),

                  //sections[index]['date'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<Userprovider>(
                                  create: (_) => Userprovider(),
                                  child: Profile(
                                      nUser: sections[index]['userid']))),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: sections.runtimeType.toString() == "List<dynamic>"
                ? sections.length
                : 0,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context); //avoid app from exiting
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: c1,
          title: Row(
            children: <Widget>[
              Text('Your Scan History '),
              RotationTransition(
                turns: Tween(begin: 0.0, end: -.1)
                    .chain(CurveTween(curve: Curves.elasticIn))
                    .animate(_animationController),
                child: Badge(
                  badgeContent:
                      Text('3', style: TextStyle(color: Colors.white)),
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
//          title: new Text("Login"),
        ),
        body: _buildChatList(),
      ),
    );
  }
}
