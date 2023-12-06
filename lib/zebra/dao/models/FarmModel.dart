class FarmModel {
  String? farmName;
  String? farmAddress;
  double? farmArea;
  String? unit;
  String? farmType;
  bool isActive;
  DateTime? createdDate;


  FarmModel({
    this.farmName,
    this.farmAddress,
    this.farmArea,
    this.unit,
    this.farmType,
    this.isActive = true,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmName': farmName,
      'farmAddress': farmAddress,
      'farmArea': farmArea,
      'unit': unit,
      'farmType': farmType,
      'isActive': isActive ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory FarmModel.fromMap(Map<String, dynamic> map) {
    return FarmModel(
      farmName: map['farmName'],
      farmAddress: map['farmAddress'],
      farmArea: map['farmArea'],
      unit: map['unit'],
      farmType: map['farmType'],
      isActive: map['isActive'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
