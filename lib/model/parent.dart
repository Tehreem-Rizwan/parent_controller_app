import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parental_control_app/model/app_information.dart';

class Parent {
  String userID;
  String name;
  String age;
  String deviceToken;
  String latitude;
  String longitude;
  List<AppInformation> appInformations;
  String parentCode;
  Parent(this.age, this.deviceToken, this.name, this.userID,
      this.appInformations, this.latitude, this.longitude, this.parentCode);
  Map<String, dynamic> toJSON() {
    return {
      "userId": userID,
      "name": name,
      "age": age,
      "devicetoken": deviceToken,
      "latitude": latitude,
      "longitude": longitude,
      "appInformations": appInformations.map((e) => e.toJSON()).toList(),
      "parentCode": parentCode
    };
  }

  factory Parent.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return Parent(
      data['age'],
      data['devicetoken'],
      data['name'],
      data['userId'],
      data['latitude'],
      data['longitude'],
      data['appInformations'],
      data['parentCode'],
    );
  }
}
