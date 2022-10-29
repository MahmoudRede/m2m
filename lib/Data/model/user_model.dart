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
    required this.isConfirmed,
    required this.month,
    required this.year,
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
  final bool isConfirmed;
  final String month;
  final String year;

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
    isConfirmed: json["isConfirmed"],
    month: json["month"],
    year: json["year"],
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
    "isConfirmed": isConfirmed,
    "month": month,
    "year": year,
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