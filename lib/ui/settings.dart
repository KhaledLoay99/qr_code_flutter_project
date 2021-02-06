import 'package:Dcode/logic/userProfile.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Dcode/providers/Userprovider.dart';

import "package:provider/provider.dart";

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
              backgroundColor: Colors.white,
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
                backgroundColor: Colors.white,
                appBar: new AppBar(
                  title: Row(
                    children: [
                      Text('Settings '),
                      Image.asset(
                        'images/settings.png',
                        height: 30,
                      ),
                    ],
                  ),
                  backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
                ),
                body: prog
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        child: ListView(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 20,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<Userprovider>(
                                            create: (_) => Userprovider(),
                                            child: Profile())),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch, // add this
                                children: <Widget>[
                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: Icon(
                                  //     Icons.account_circle,
                                  //     color: Colors.blueGrey,
                                  //     size: 50.0,
                                  //   ),
                                  // ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(48.0),
                                      topRight: Radius.circular(48.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: _imageUrl != null
                                                ? NetworkImage(_imageUrl)
                                                : AssetImage(
                                                    "images/user.png")),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.blueGrey,
                                          size: 30.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            ' ' +
                                                userList[userIndex]
                                                    .get_username,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Colors.blueGrey,
                                          size: 30.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            ' ' +
                                                FirebaseAuth
                                                    .instance.currentUser.email,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 20,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              // onTap: () =>
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch, // add this
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(48.0),
                                      topRight: Radius.circular(48.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "images/qr-code.png")),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Center(
                                      child: Text(
                                        "You Have ${userList[userIndex].get_noOfChats} Contacts",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          child: RaisedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => intro()),
                                (Route<dynamic> route) =>
                                    false, // remove back arrow
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Logout ".toUpperCase(),
                                    style: TextStyle(fontSize: 25)),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              side: BorderSide(color: Colors.cyan),
                            ),
                            color: Colors.cyan,
                            textColor: Colors.white,
                          ),
                          width: 10,
                          height: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ]))));
  }
}
