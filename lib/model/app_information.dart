class appInformation {
  String appName;
  String appPackageName;
  String screenTime;
  String lastUserTime;
  appInformation(
      this.appName, this.appPackageName, this.lastUserTime, this.screenTime);
  Map<String, dynamic> toJSON() {
    return {
      'appName': appName,
      'appPackageName': appPackageName,
      'screenTime': screenTime,
      'lastUserTime': lastUserTime
    };
  }
}
