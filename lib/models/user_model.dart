class UserModel {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo; // photo ফিল্ড যোগ করা হয়েছে
  String? createdDate;

  UserModel({
    this.sId,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.photo,
    this.createdDate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo']; // API থেকে photo রিসিভ করা হচ্ছে
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['photo'] = photo; // JSON-এ photo রিটার্ন করা হচ্ছে
    data['createdDate'] = createdDate;
    return data;
  }
}