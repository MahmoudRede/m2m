class UserModel {
  UserModel({
    required this.username,
    required this.email,
    required this.uId,
    required this.phone,
    required this.profileImage,
    required this.nationalIdImage,
    required this.personalImage,
    required this.package,
    required this.wallet,
    required this.government,
    required this.age,
    required this.skills,
    required this.inviteCode,
    required this.userCode,
    required this.rank,
    required this.isConfirmed,
    required this.month,
    required this.year,
    required this.userSkill1,
    required this.userSkill2,
    required this.userSkill3,
    required this.userSkill4,
    required this.userSkill5,
    required this.userSkill6,
    required this.userSkill7,
    required this.userSkill8,
  });

  final String username;
  final String email;
  final String uId;
  final String phone;
  final String profileImage;
  final String nationalIdImage;
  final String personalImage;
  final Package package;
  final Wallet wallet;
  final String government;
  final String age;
  final String skills;
  final String inviteCode;
  final String rank;
  final String userCode;
  final bool isConfirmed;
  final String month;
  final String year;
  final String userSkill1;
  final String userSkill2;
  final String userSkill3;
  final String userSkill4;
  final String userSkill5;
  final String userSkill6;
  final String userSkill7;
  final String userSkill8;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    email: json["email"],
    uId: json["uId"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    nationalIdImage: json["nationalIdImage"],
    personalImage: json["personalImage"],
    package: Package.fromMap(json["package"]),
    wallet: Wallet.fromMap(json["wallet"]),
    government: json["government"],
    age: json["age"],
    skills: json["skills"],
    inviteCode: json["inviteCode"],
    userCode: json["userCode"],
    rank: json["rank"],
    isConfirmed: json["isConfirmed"],
    month: json["month"],
    year: json["year"],
    userSkill1: json["userSkill1"],
    userSkill2: json["userSkill2"],
    userSkill3: json["userSkill3"],
    userSkill4: json["userSkill4"],
    userSkill5: json["userSkill5"],
    userSkill6: json["userSkill6"],
    userSkill7: json["userSkill7"],
    userSkill8: json["userSkill8"],
  );

  Map<String, dynamic> toMap() => {
    "username": username,
    "email": email,
    "uId": uId,
    "phone": phone,
    "profileImage": profileImage,
    "nationalIdImage": nationalIdImage,
    "personalImage": personalImage,
    "package": package.toMap(),
    "wallet": wallet.toMap(),
    "government": government,
    "age": age,
    "skills": skills,
    "inviteCode": inviteCode,
    "userCode": userCode,
    "rank": rank,
    "isConfirmed": isConfirmed,
    "month": month,
    "year": year,
    "userSkill1": userSkill1,
    "userSkill2": userSkill2,
    "userSkill3": userSkill3,
    "userSkill4": userSkill4,
    "userSkill5": userSkill5,
    "userSkill6": userSkill6,
    "userSkill7": userSkill7,
    "userSkill8": userSkill8,
  };
}

class Package {
  Package({
    required this.packageName,
    required this.packageId,
    required this.isVerified,
  });

  final String packageName;
  final String packageId;
  final bool isVerified;

  factory Package.fromMap(Map<String, dynamic> json) => Package(
    packageName: json["packageName"],
    packageId: json["packageId"],
    isVerified: json["isVerified"],
  );

  Map<String, dynamic> toMap() => {
    "packageName": packageName,
    "packageId": packageId,
    "isVerified": isVerified,
  };
}


class Wallet {
  Wallet({
    required this.money,
    required this.point,
  });

  final dynamic money;
  final dynamic point;

  factory Wallet.fromMap(Map<String, dynamic> json) => Wallet(
    money: json["money"],
    point: json["point"],
  );

  Map<String, dynamic> toMap() => {
    "money": money,
    "point": point,
  };
}