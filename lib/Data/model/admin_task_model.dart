class AdminTaskModel {
  AdminTaskModel({
    required this.taskId,
    required this.taskDescription,
    required this.taskUrl,
    required this.taskPrice,
    required this.taskType,
    required this.taskTime,
    required this.taskIsConfirmed,
    required this.taskIsUploaded,
  });

  final String taskId;
  final String taskDescription;
  final String taskUrl;
  final String taskPrice;
  final String taskType;
  final String taskTime;
  final bool taskIsConfirmed;
  final bool taskIsUploaded;

  factory AdminTaskModel.fromMap(Map<String, dynamic> json) => AdminTaskModel(
    taskId: json["taskId"],
    taskDescription: json["taskDescription"],
    taskUrl: json["taskUrl"],
    taskPrice: json["taskPrice"],
    taskType: json["taskType"],
    taskTime: json["taskTime"],
    taskIsConfirmed: json["taskIsConfirmed"],
    taskIsUploaded: json["taskIsUploaded"],
  );

  Map<String, dynamic> toMap() => {
    "taskId": taskId,
    "taskDescription": taskDescription,
    "taskUrl": taskUrl,
    "taskPrice": taskPrice,
    "taskType": taskType,
    "taskTime": taskTime,
    "taskIsConfirmed": taskIsConfirmed,
    "taskIsUploaded": taskIsUploaded,
  };
}
