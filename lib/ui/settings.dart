import 'package:Dcode/logic/userProfile.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Dcode/providers/Userprovider.dart';
import 'package:path/path.dart';

import "package:provider/provider.dart";
import 'dart:io';

import 'intro.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Userprofile userprofileData = new Userprofile();
  bool prog = true;
  bool err = false;
  var user_id;
  var ref;
  String _imageUrl;
  List<Userprofile> userList;

  int userIndex;
  @override
  void initState() {
    Provider.of<Userprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    var uPic;
    try {
      ref = FirebaseStorage.instance
          .ref()
          .child('user' + FirebaseAuth.instance.currentUser.uid + '.png');
      ref.getDownloadURL().then((loc) {
        setState(() {
          _imageUrl = loc;
        });
      });
    } catch (error) {
      _imageUrl = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userList = Provider.of<Userprovider>(this.context, listen: true).user;
    user_id = FirebaseAuth.instance.currentUser.uid;
    userIndex = userList.indexWhere((element) => element.id == user_id);
    if (prog == false) {
      if (userList.isEmpty) {
        err = true;
      }
    }
    return err
        ? WillPopScope(
            onWillPop: () async {
              return Navigator.canPop(context); // avoid app from exiting
            },
            child: Scaffold(
              body: new AlertDialog(
                title: new Text('Error'),
                content: new Text('Error while fetching data!'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Exit'),
                  ),
                ],
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              return Navigator.canPop(context); // avoid app from exiting
            },
            child: Scaffold(
                appBar: new AppBar(
                  //kkkk
                  title:
                      Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
//          title: new Text("Login"),
                  backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
                ),
                body: prog
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        child: ListView(children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, top: 20.0),
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: _imageUrl != null
                                          ? NetworkImage(_imageUrl)
                                          : AssetImage("images/user.png"))),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              alignment: Alignment.topRight,
                              height: MediaQuery.of(context).size.height / 6,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 15.0, top: 9.0),
                                    child: Text(
                                      userList[userIndex].get_username,
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 25.0),
                                    child: Text(
                                      //userprofileData.get_mail,
                                      FirebaseAuth.instance.currentUser.email,
                                      style: TextStyle(
                                        letterSpacing: 2,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 30,
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    child: RaisedButton(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Edit Profile",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Icon(
                                            Icons.edit,
                                            color: Colors.blueGrey,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Color.fromRGBO(110, 204, 234, 1.0),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider<
                                                          Userprovider>(
                                                      create: (_) =>
                                                          Userprovider(),
                                                      child: Profile())),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            /*decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),*/
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 15,
                                top: MediaQuery.of(context).size.height / 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "General Settings",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          90),
                                  width:
                                      MediaQuery.of(context).size.width / 4.3,
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          35,
                                      left: MediaQuery.of(context).size.width /
                                          15),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                14,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Help",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.help),
                                              alignment: Alignment.topCenter,
                                              onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => logout()),
                                                // );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                65),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 2,
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                14,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Logout",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.logout),
                                              alignment: Alignment.topCenter,
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          intro()),
                                                  (Route<dynamic> route) =>
                                                      false, // remove back arrow
                                                );

                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => logout()),
                                                // );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          30),
                                  child: Text(
                                    "Miscellaneous",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          90),
                                  width:
                                      MediaQuery.of(context).size.width / 4.3,
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          35,
                                      left: MediaQuery.of(context).size.width /
                                          20),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                14,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Report a problem",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.report),
                                              alignment: Alignment.topCenter,
                                              onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => logout()),
                                                // );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                65),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 2,
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                14,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Share the application",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.share),
                                              alignment: Alignment.topCenter,
                                              onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => logout()),
                                                // );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ]))));
  }
}
