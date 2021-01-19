import 'package:Dcode/logic/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/providers/Userprovider.dart';
import "package:provider/provider.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  @override
  static Pattern pattern;
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _controller = new TextEditingController();
  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  TextFormField test;
  bool _isEnabled;
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  final _formKey = GlobalKey<FormState>();
  TextEditingController _customController;
  Userprofile userProfileData = new Userprofile();
  List<Userprofile> userList;
  bool prog;
  bool err;
  var update;
  String _imageUrl;
  File uImage;
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;
  bool _loading = false;
  bool save_done = true;
  bool save_done2 = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userList = Provider.of<Userprovider>(this.context, listen: true).user;
    update = Provider.of<Userprovider>(this.context);
    prog = Provider.of<Userprovider>(this.context).prog;
    err = Provider.of<Userprovider>(this.context).err;
    if (prog == false) {
      var ref = FirebaseStorage.instance.ref().child(userList[0].profileImage);
      ref.getDownloadURL().then((loc) {
        setState(() {
          _imageUrl = loc;
        });
      });
    }
  }

  createAlertDialog(BuildContext context, String type, String val, var update) {
    _customController = new TextEditingController(text: val);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: type == 'firstname'
                ? Text("Your first name")
                : type == 'lastname'
                    ? Text("Your last name")
                    : Text("Your $type"),
            content: Container(
              height: 125,
              width: 250,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (type == "firstname") {
                          if (value.isEmpty) {
                            return 'Please Enter First Name';
                          }
                          if (value.length < 3) {
                            return 'First Name is too short';
                          }
                          if (value.length > 18) {
                            return 'First Name is too long';
                          }
                          if (!validCharacters.hasMatch(value)) {
                            return 'First Name should be alphabets only';
                          }
                          return null;
                        }
                        if (type == "lastname") {
                          if (value.isEmpty) {
                            return 'Please Enter Last Name';
                          }
                          if (value.length < 3) {
                            return 'Last Name is too short';
                          }

                          if (value.length > 18) {
                            return 'Last Name is too long';
                          }
                          if (!validCharacters.hasMatch(value)) {
                            return 'Last Name should be alphabets only';
                          }
                          return null;
                        }
                        if (type == "username") {
                          if (value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          if (value.length > 25) {
                            return 'Username is too long';
                          }
                          if (value.length < 11) {
                            return 'Username is too short';
                          }
                          if (!value.contains('@dcode.com')) {
                            return 'username should end with @decode.com';
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
                        //print(_customController.text);
                        if (_formKey.currentState.validate()) {
                          update.updateData(
                              "fWjVRpN5z0JeOyPJrxbK",
                              type == 'firstname'
                                  ? {'firstname': _customController.text}
                                  : type == 'lastname'
                                      ? {'lastname': _customController.text}
                                      : type == 'username'
                                          ? {'username': _customController.text}
                                          : {
                                              'location': _customController.text
                                            });
                        }
                        Navigator.pop(context);
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
                          data: userList[0].id,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ),
                    !_loading
                        ? Visibility(
                            visible: save_done,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                screenshotController
                                    .capture(delay: Duration(milliseconds: 10))
                                    .then((File image) async {
                                  if (image != null && image.path != null) {
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
                                }).catchError((onError) {
                                  print(onError);
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_circle_down),
                                  Text("Download Your Qr Code"),
                                ],
                              ),
                            ))
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
                padding: qr
                    ? EdgeInsets.only(left: 310, top: 10)
                    : EdgeInsets.only(left: 310, top: 10),
                child: qr
                    ? IconButton(
                        icon: Icon(Icons.qr_code),
                        onPressed: () {
                          show_Qr();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          createAlertDialog(
                              this.context, type, hintText, update);
                        },
                      ),
              )
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        uImage = image;
      });
      String filename = basename(uImage.path);
      var firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
      var uploadTask = firebaseStorageRef.putFile(uImage).then((loc) {
        update.updateData("fWjVRpN5z0JeOyPJrxbK", {'profileImage': filename});
      });
    }

    return err
        ? Scaffold(
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
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: new AppBar(
              title: Image.asset('images/Dcode_home.jpg', fit: BoxFit.cover),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: const Color.fromRGBO(110, 204, 234, 1.0),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => notify()),
                  );
                } else if (value == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chatlist()),
                  );
                } else if (value == 3) {
                  /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );*/
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
                    style: TextStyle(color: Colors.black45),
                  ),
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black45,
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
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ],
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
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 5),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: _imageUrl != null
                                                  ? uImage == null
                                                      ? NetworkImage(_imageUrl)
                                                      : FileImage(uImage)
                                                  : AssetImage(
                                                      "images/user.png"))),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 140,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2),
                                      margin: EdgeInsets.only(bottom: 50),
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
                                    ),
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
                                  hintText: userList[0].first_name,
                                  qr: false,
                                  type: "firstname",
                                  update: update),
                              textfield(
                                  hintText: userList[0].last_name,
                                  qr: false,
                                  type: "lastname",
                                  update: update),
                              textfield(
                                  hintText: userList[0].get_mail,
                                  qr: false,
                                  type: "username",
                                  update: update),
                              textfield(
                                  hintText: userList[0].get_location,
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
