//EventModel.dart
import 'dart:core';
class EventModel {
  int? eventId;
  late int userId;
  late int farmId;
  late int cropId;
  late String eventType;
  final DateTime startDate;
  DateTime? endDate;
  String? notes;
  bool? isDone;
  bool isActive;
  bool isExpanded;
  DateTime? createdDate;

  EventModel(
      {this.eventId,
      required this.farmId,
      required this.cropId,
      required this.userId,
      required this.eventType,
      required this.startDate,
      this.endDate,
      this.notes,
      this.isDone,
      this.isActive = true,
      this.isExpanded = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'farmId': this.farmId,
      'cropId': this.cropId,
      'userId': this.userId,
      'eventType': this.eventType,
      'startDate': this.startDate?.toIso8601String(),
      'endDate': this.endDate?.toIso8601String(),
      'notes': this.notes,
      'isDone': this.isDone,
      'isActive': this.isActive,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'],
      farmId: map['farmId'],
      cropId: map['cropId'],
      userId: map['userId'],
      eventType: map['eventType'],
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
