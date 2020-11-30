class notifylogic {
  Map msgs = {'Mohamed Ahmed': 'Hello, my friend'};
  Map purchasers = {
    'Ahmed El Banaa': 'New Purchaser is intersted',
    'Khaled Loay': 'New Purchaser is intersted'
  };

  String qrImage = "images/qr_code.png";

  Map getmsgs() {
    return msgs;
  }

  Map getpurchasers() {
    return purchasers;
  }

  String get get_qrImage {
    return qrImage;
  }
}
