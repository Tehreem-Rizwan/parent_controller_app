import 'package:parental_control_app/model/app_information.dart';

class Children {
  String userID;
  String name;
  String age;
  String mobile;
  String deviceToken;
  String latitude;
  String longitude;
  List<appInformation> appInformations;
  Children(
    this.userID,
    this.name,
    this.age,
    this.mobile,
    this.deviceToken,
    this.latitude,
    this.longitude,
    this.appInformations,
  );
  Map<String, dynamic> toJSON() {
    return {
      'userId': userID,
      'name': name,
      'age': age,
      'mobile': mobile,
      'devicetoken': deviceToken,
      'longitude': longitude,
      'latitude': latitude,
      'appInfomations': appInformations.map((e) => e.toJSON()).toList(),
    };
  }
}
