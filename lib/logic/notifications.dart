class notifylogic {
  List<String> names = new List();
  List<String> messages = new List();

  List<String> Purchasers = new List();

  notifylogic() {
    Purchasers.add("ahmed mohamed");
    Purchasers.add("youssef karim");

    names.add("Mohamed Ahmed");
    messages.add("hello friend");
  }

  String qrImage = "images/qr_code.png";

  List getMsgs() {
    return messages;
  }

  List getNames() {
    return names;
  }

  List getpurchasers() {
    return Purchasers;
  }

  String get get_qrImage {
    return qrImage;
  }
}
