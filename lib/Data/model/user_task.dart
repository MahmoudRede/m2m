class UserTaskModel {
  UserTaskModel({
    required this.taskId,
    required this.taskDescription,
    required this.taskUrl,
    required this.taskPrice,
    required this.taskType,
    required this.taskTimer,
    required this.taskIsConfirmed,
    required this.taskIsUploaded,
  });

  final String taskId;
  final String taskDescription;
  final String taskUrl;
  final String taskPrice;
  final String taskType;
  final String taskTimer;
  final bool taskIsConfirmed;
  final bool taskIsUploaded;

  factory UserTaskModel.fromMap(Map<String, dynamic> json) => UserTaskModel(
    taskId: json["taskId"],
    taskDescription: json["taskDescription"],
    taskUrl: json["taskUrl"],
    taskPrice: json["taskPrice"],
    taskType: json["taskType"],
    taskTimer: json["taskTime"],
    taskIsConfirmed: json["taskIsConfirmed"],
    taskIsUploaded: json["taskIsUploaded"],
  );

  Map<String, dynamic> toMap() => {
    "taskId": taskId,
    "taskDescription": taskDescription,
    "taskUrl": taskUrl,
    "taskPrice": taskPrice,
    "taskType": taskType,
    "taskTime": taskTimer,
    "taskIsConfirmed": taskIsConfirmed,
    "taskIsUploaded": taskIsUploaded,
  };
}
