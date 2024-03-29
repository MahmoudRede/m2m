class UploadTaskModel {
  UploadTaskModel({
    required this.taskId,
    required this.taskImages,
    required this.userName,
    required this.userImage,
    required this.userUId,
    required this.taskConfirmed,
    required this.packageName,
    required this.phone,
    required this.price,
  });

  final String taskId;
  final List<String> taskImages;
  final String userName;
  final String userImage;
  final String userUId;
  final bool taskConfirmed;
  final String packageName;
  final String phone;
  final String price;

  factory UploadTaskModel.fromMap(Map<String, dynamic> json) => UploadTaskModel(
    taskId: json["taskId"]??"",
    taskImages: List<String>.from(json["taskImages"].map((x) => x)),
    userName: json["userName"]??"",
    userImage: json["userImage"]??"",
    userUId: json["userUId"]??"",
    taskConfirmed: json["taskConfirmed"]??false,
    packageName: json["packageName"]??"",
    phone: json["phone"]??"",
    price: json["price"]??"",
  );

  Map<String, dynamic> toMap() => {
    "taskId": taskId,
    "taskImages": List<dynamic>.from(taskImages.map((x) => x)),
    "userName": userName,
    "userImage": userImage,
    "userUId": userUId,
    "taskConfirmed": taskConfirmed,
    "packageName": packageName,
    "phone": phone,
    "price": price,
  };

}