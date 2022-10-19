class TaskModel {
  TaskModel({
      required this.taskId,
      required this.taskTitle,
      required this.taskType,
      required this.taskTime,
      required this.taskIsDone,
      required this.taskIsTimeOut,
      required this.taskIsUploaded,
  });

  final String taskId;
  final String taskTitle;
  final String taskType;
  final String taskTime;
  final bool taskIsDone;
  final bool taskIsTimeOut;
  final bool taskIsUploaded;

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
    taskId: json["taskId"]??"",
    taskTitle: json["taskTitle"]??"",
    taskType: json["taskType"]??"",
    taskTime: json["taskTime"]??"",
    taskIsDone: json["taskIsDone"]??false,
    taskIsTimeOut: json["taskIsTimeOut"]??false,
    taskIsUploaded: json["taskIsUploaded"]??false,
  );

  Map<String, dynamic> toMap() => {
    "taskId": taskId,
    "taskTitle": taskTitle,
    "taskType": taskType,
    "taskTime": taskTime,
    "taskIsDone": taskIsDone,
    "taskIsTimeOut": taskIsTimeOut,
    "taskIsUploaded": taskIsUploaded,
  };
}