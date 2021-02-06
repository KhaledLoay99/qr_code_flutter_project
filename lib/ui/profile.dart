import 'package:Dcode/logic/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:Dcode/providers/Userprovider.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:provider/provider.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class Profile extends StatefulWidget {
  @override
  static Pattern pattern;
  final String nUser;
  _ProfileState createState() => _ProfileState(nUser);
  Profile({Key key, this.nUser}) : super(key: key);
}

class _ProfileState extends State<Profile> {
  String nUser;
  _ProfileState(this.nUser);
  final TextEditingController _controller = new TextEditingController();
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  TextFormField test;
  bool _isEnabled;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  List<Userprofile> userList;
  bool prog = true;
  bool err = false;
  var update;
  String _imageUrl;
  File uImage;
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  bool _loading = false;
  bool save_done = true;
  bool save_done2 = false;
  var user_id;
  int userIndex;
  var ref;
  List userNames = [];

  @override
  void initState() {
    Provider.of<Userprovider>(this.context, listen: false)
        .fetchdata()
        .then((value) {
      prog = false;
    });
    update = Provider.of<Userprovider>(this.context, listen: false);
    var uPic;
    if (nUser == null)
      uPic = FirebaseAuth.instance.currentUser.uid;
    else
      uPic = nUser;
    try {
      ref = FirebaseStorage.instance.ref().child('user' + uPic + '.png');
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

  createAlertDialog(BuildContext context, String type, String val, var update) {
    _customController = new TextEditingController(text: val);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your $type"),
            content: Container(
              height: 125,
              width: 250,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (type == "username") {
                          if (value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          if (value.length > 25) {
                            return 'Username is too long';
                          }
                          if (value.length < 3) {
                            return 'Username is too short';
                          }

                          userList.forEach((user) {
                            if (user.id != userList[userIndex].id) {
                              userNames.add(user.get_username);
                            }
                          });
                          if (userNames.contains(value)) {
                            return 'Username already taken';
                          }

                          return null;
                        }
                        if (type == "location") {
                          if (value.isEmpty) {
                            return 'Please Enter your location';
                          }
                          if (value.length > 15) {
                            return 'Location is too long';
                          }
                          if (value.length < 5) {
                            return 'Location is too short';
                          }
                          return null;
                        }
                      },
                      controller: _customController,
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          update.updateData(
                              user_id,
                              type == 'username'
                                  ? {'username': _customController.text}
                                  : {'location': _customController.text});
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  show_Qr() {
    var userTake = FirebaseAuth.instance.currentUser;
    var user_id;
    return showDialog(
        context: this.context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text("Your Qr Code"),
              ),
              content: Container(
                height: 350,
                width: 250,
                child: Column(
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: userTake.uid,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                    !_loading
                        ? Visibility(
                            visible: save_done,
                            child: (nUser == null)
                                ? RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () {
                                      screenshotController
                                          .capture(
                                              delay: Duration(milliseconds: 10))
                                          .then((File image) async {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                        ].request();
                                        if (statuses[Permission.storage]
                                            .isDenied) {
                                          return Text("NEED A Permission");
                                        }
                                        if (image != null &&
                                            image.path != null) {
                                          setState(() {
                                            _loading = true;
                                          });
                                          GallerySaver.saveImage(image.path)
                                              .then((value) => setState(() {
                                                    _loading = false;

                                                    save_done = false;
                                                    save_done2 = true;
                                                  }));
                                        }
                                      }).catchError((onError) {});
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_circle_down),
                                        Text("Download Your Qr Code"),
                                      ],
                                    ),
                                  )
                                : Text('QR'))
                        : CircularProgressIndicator(),
                    Visibility(
                        visible: save_done2,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        )),
                    Visibility(
                      visible: save_done2,
                      child: Text("Saved To Gallery"),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget textfield(
      {@required String hintText, bool qr, String type, var update}) {
    return Material(
        elevation: 4,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          child: Stack(children: [
            test = TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.white30,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none)),
            ),
            Row(children: [
              Container(
                width: MediaQuery.of(this.context).size.width * 0.8,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(this.context).size.width / 1.25,
                    top: 10),
                child: qr
                    ? IconButton(
                        icon: Icon(Icons.qr_code),
                        onPressed: () {
                          show_Qr();
                        },
                      )
                    : (nUser == null)
                        ? IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              createAlertDialog(
                                  this.context, type, hintText, update);
                            },
                          )
                        : null,
              )
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (prog == false) {
      if (userList.isEmpty) {
        err = true;
      }
      if (nUser == null) {
        user_id = FirebaseAuth.instance.currentUser.uid;
      } else {
        user_id = nUser;
      }
      userIndex = userList.indexWhere((element) => element.id == user_id);
      /*try {
        ref = FirebaseStorage.instance
            .ref()
            .child(userList[userIndex].profileImage);
        ref.getDownloadURL().then((loc) {
          setState(() {
            _imageUrl = loc;
          });
        });
      } catch (error) {
        _imageUrl = null;
      }*/
    }
    userList = Provider.of<Userprovider>(this.context, listen: true).user;
    Future getImage() async {
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 600);
      setState(() {
        uImage = image;
      });
      String filename = "user" + user_id + '.png';
      var firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
      var uploadTask = firebaseStorageRef.putFile(uImage).then((loc) {
        update.updateData(user_id, {'profileImage': filename});
      });
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
              resizeToAvoidBottomInset: false,
              appBar: new AppBar(
                title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
                backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
              ),
              body: prog
                  ? Center(child: CircularProgressIndicator())
                  : ListView(children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Stack(alignment: Alignment.topCenter, children: [
                            CustomPaint(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),
                              painter: HeaderCurvedContainer(),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
                                        fontSize: 35,
                                        letterSpacing: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 5),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: _imageUrl != null
                                                    ? uImage == null
                                                        ? NetworkImage(
                                                            _imageUrl)
                                                        : FileImage(uImage)
                                                    : AssetImage(
                                                        "images/user.png"))),
                                      ),
                                      (nUser == null)
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6.2,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.2),
                                              margin:
                                                  EdgeInsets.only(bottom: 50),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black54,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    getImage();
                                                  },
                                                ),
                                              ),
                                            )
                                          : Text(''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 5.5),
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                textfield(
                                    hintText: userList[userIndex].get_username,
                                    qr: false,
                                    type: "username",
                                    update: update),
                                textfield(
                                    hintText: userList[userIndex].get_location,
                                    qr: false,
                                    type: "location",
                                    update: update),
                                textfield(
                                  hintText: 'QR Code',
                                  qr: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
            ),
          );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(110, 204, 234, 1.0);
    Path path = Path()
      ..lineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
