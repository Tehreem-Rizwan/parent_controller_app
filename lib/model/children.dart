import 'package:parental_control_app/model/app_information.dart';

class Children {
  String userID;
  String name;
  String age;
  String mobile;
  String deviceToken;
  List<appInformation> appInformations;
  Children(this.userID, this.name, this.age, this.mobile, this.deviceToken,
      this.appInformations);
}
