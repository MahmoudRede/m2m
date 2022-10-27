class UserTaskModel {
  UserTaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskType,
    required this.taskTimer,
    required this.taskPrice,

  });

  final String taskTitle;
  final String taskDescription;
  final String taskType;
  final String taskTimer;
  final String taskPrice;

  factory UserTaskModel.fromMap(Map<String, dynamic> json) => UserTaskModel(
    taskTitle: json["taskTitle"],
    taskDescription: json["taskDescription"],
    taskType: json["taskType"],
    taskTimer: json["taskTimer"],
    taskPrice: json["taskPrice"],
  );

  Map<String, dynamic> toMap() => {
    "taskTitle": taskTitle,
    "taskDescription": taskDescription,
    "taskType": taskType,
    "taskTimer": taskTimer,
    "taskPrice": taskPrice,
  };
}