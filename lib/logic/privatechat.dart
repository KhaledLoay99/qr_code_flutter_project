import 'message.dart';

class privatechat {
  List<message> userchat = new List();

  privatechat() {
    message m1 = new message("how my friend", "3:00PM");
    message m2 = new message(
        "hello,how are you mdsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadsaadsassadadsdsan? ",
        "3:04PM");
    message m3 = new message("I am fine thanks", "3:04PM");
    message m4 = new message("what is the lecture time", "3:05PM");
    userchat.add(m1);
    userchat.add(m2);
    userchat.add(m3);
    userchat.add(m4);
  }
  void setMessage(String text, var time) {
    message m = new message(text, time);
    userchat.add(m);
  }

  List getMessages() {
    return userchat;
  }
}
