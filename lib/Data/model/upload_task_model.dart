class UploadTaskModel {
  UploadTaskModel({
     required this.taskId,
     required this.taskImage,
     required this.userName,
     required this.userImage,
     required this.userUId,
     required this.taskConfirmed,
     required this.package,
     required this.phone,
  });

  final String taskId;
  final String taskImage;
  final String userName;
  final String userImage;
  final String userUId;
  final bool taskConfirmed;
  final String package;
  final String phone;

  factory UploadTaskModel.fromMap(Map<String, dynamic> json) => UploadTaskModel(
    taskId: json["taskId"]??"",
    taskImage: json["taskImage"]??"",
    userName: json["userName"]??"",
    userImage: json["userImage"]??"",
    userUId: json["userUId"]??"",
    taskConfirmed: json["taskConfirmed"]??false,
    package: json["package"]??"",
    phone: json["phone"]??"",
  );

  Map<String, dynamic> toMap() => {
    "taskId": taskId,
    "taskImage": taskImage,
    "userName": userName,
    "userImage": userImage,
    "userUId": userUId,
    "taskConfirmed": taskConfirmed,
    "package": package,
    "phone": phone,
  };
}