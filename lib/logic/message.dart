class message {
  String text;
  var time;

  message(String text, var time) {
    this.text = text;
    this.time = time;
  }

  void setText(String text) {
    this.text = text;
  }

  String getText() {
    return this.text;
  }

  void setTime(String time) {
    this.time = time;
  }

  String getTime() {
    return this.time;
  }
}
