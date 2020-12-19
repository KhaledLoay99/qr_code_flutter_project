class Carprofile {
  String id;
  String carmodel;
  bool salestatus;
  String location;
  String phonenumber;
  String carprofileImage; //= "images/car.png";
  String owner;
  Carprofile(
      {this.id,
      this.carmodel,
      this.salestatus,
      this.location,
      this.phonenumber,
      this.carprofileImage,
      this.owner});
  String get get_carmodel {
    return carmodel;
  }

  bool get get_salestatus {
    return salestatus;
  }

  String get get_location {
    return location;
  }

  String get get_phonenumber {
    return phonenumber;
  }

  String get get_carprofileImage {
    return carprofileImage;
  }
}
