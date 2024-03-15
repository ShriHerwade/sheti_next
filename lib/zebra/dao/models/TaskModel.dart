import 'dart:core';
class TaskModel {
  int? taskId;
  late int userId;
  late int farmId;
  late int cropId;
  late String taskType;
  final DateTime startDate;
  DateTime? endDate;
  String? notes;
  bool? isDone;
  bool isActive;
  bool isExpanded;
  DateTime? createdDate;

  TaskModel(
      {this.taskId,
      required this.farmId,
      required this.cropId,
      required this.userId,
      required this.taskType,
      required this.startDate,
      this.endDate,
      this.notes,
      this.isDone,
      this.isActive = true,
      this.isExpanded = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId,
      'farmId': this.farmId,
      'cropId': this.cropId,
      'userId': this.userId,
      'taskType': this.taskType,
      'startDate': this.startDate?.toIso8601String(),
      'endDate': this.endDate?.toIso8601String(),
      'notes': this.notes,
      'isDone': this.isDone,
      'isActive': this.isActive,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'],
      farmId: map['farmId'],
      cropId: map['cropId'],
      userId: map['userId'],
      taskType: map['taskType'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      notes: map['notes'],
      isDone: map['isDone'] == 0,
      isActive: map['isActive'] == 0,
      isExpanded: map['isExpanded'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
