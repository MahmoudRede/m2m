class PaymentModel {
  PaymentModel({
     required this.packageId,
     required this.paymentImage,
     required this.userName,
     required this.userImage,
     required this.userUId,
     required this.isVerified,
     required this.packageName,
     required this.userPhone,
  });

  final String packageId;
  final String paymentImage;
  final String userName;
  final String userImage;
  final String userUId;
  final bool isVerified;
  final String packageName;
  final String userPhone;

  factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
    packageId: json["packageId"]??"",
    paymentImage: json["paymentImage"]??"",
    userName: json["userName"]??"",
    userImage: json["userImage"]??"",
    userUId: json["userUId"]??"",
    isVerified: json["isVerified"]??false,
    packageName: json["packageName"]??"",
    userPhone: json["phone"]??"",
  );

  Map<String, dynamic> toMap() => {
    "packageId": packageId,
    "paymentImage": paymentImage,
    "userName": userName,
    "userImage": userImage,
    "userUId": userUId,
    "isVerified": isVerified,
    "packageName": packageName,
    "userPhone": userPhone,
  };
}