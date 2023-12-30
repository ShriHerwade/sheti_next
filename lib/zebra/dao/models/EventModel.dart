class EventModel {
  int? eventId;
  late int farmId;
  late int cropId;
  late String eventType;
  final DateTime startDate;
  DateTime? endDate;
  String? details;
  bool? isDone;
  bool isActive;
  DateTime? createdDate;

  EventModel(
      {this.eventId,
      required this.farmId,
      required this.cropId,
      required this.eventType,
      required this.startDate,
      this.endDate,
      this.details,
      this.isDone,
      this.isActive = true,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'farmId': this.farmId,
      'cropId': this.cropId,
      'eventType': this.eventType,
      'startDate': this.startDate?.toIso8601String(),
      'endDate': this.endDate?.toIso8601String(),
      'details': this.details,
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
      eventType: map['eventType'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      details: map['details'],
      isDone: map['isDone'] == 0,
      isActive: map['isActive'] == 0,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}