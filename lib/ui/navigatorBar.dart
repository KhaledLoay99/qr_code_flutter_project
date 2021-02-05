import 'package:Dcode/providers/Userprovider.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/notification.dart';
import 'package:Dcode/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String something;
  HomePage(this.something);
  @override
  _HomePageState createState() => _HomePageState(this.something);
}

class _HomePageState extends State<HomePage> {
  String something;
  _HomePageState(this.something);
  int selectedPage = 0;

  Color c1 = const Color.fromRGBO(110, 204, 234, 1.0);
  final _pageOptions = [
    home(),
    notify(),
    chatlist(),
    ChangeNotifierProvider<Userprovider>(
        create: (_) => Userprovider(), child: Profile()),
  ];
  @override
  void initState() {
    super.initState();
    if (something == 'something') {
      selectedPage = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: c1,
          items: [
            BottomNavigationBarItem(
              title: Text(
                'Home',
              ),
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Scan History',
              ),
              icon: Icon(Icons.qr_code_scanner_sharp),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Recent Chats',
              ),
              icon: Icon(
                Icons.chat,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                'My Profile',
              ),
              icon: Icon(
                Icons.account_circle,
              ),
            ),
          ],
          selectedItemColor: Colors.white,
          elevation: 5.0,
          unselectedItemColor: Colors.black,
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
