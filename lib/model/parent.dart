import 'package:parental_control_app/model/app_information.dart';

class Parent {
  String userID;
  String name;
  String age;
  String deviceToken;
  String latitude;
  String longitude;
  List<appInformation> appInformations;
  Parent(this.age, this.deviceToken, this.name, this.userID,
      this.appInformations, this.latitude, this.longitude);
  Map<String, dynamic> toJSON() {
    return {
      "userId": userID,
      "name": name,
      "age": age,
      "devicetoken": deviceToken,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}
