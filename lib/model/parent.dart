class Parent {
  String userID;
  String name;
  String age;
  String deviceToken;
  Parent(this.age, this.deviceToken, this.name, this.userID);
  Map<String, dynamic> toJSON() {
    return {
      "userId": userID,
      "name": name,
      "age": age,
      "devicetoken": deviceToken
    };
  }
}
