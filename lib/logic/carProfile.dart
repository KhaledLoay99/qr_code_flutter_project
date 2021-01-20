class Carprofile {
  String id;
  String carmodel;
  bool salestatus;
  String location;
  String carprofileImage; //= "images/car.png";
  String userid;
  Carprofile({
    this.id,
    this.userid,
    this.carmodel,
    this.salestatus,
    this.location,
    this.carprofileImage,
  });
  String get get_carmodel {
    return carmodel;
  }

  bool get get_salestatus {
    return salestatus;
  }

  String get get_location {
    return location;
  }

  String get get_carprofileImage {
    return carprofileImage;
  }
}
