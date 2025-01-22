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
  Parent(this.userID, this.name, this.age, this.deviceToken, this.latitude,
      this.longitude, this.appInformations, this.parentCode);
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
      data['userId'],
      data['name'],
      data['age'],
      data['devicetoken'],
      data['latitude'],
      data['longitude'],
      data['appInformations'],
      data['parentCode'],
    );
  }
}
