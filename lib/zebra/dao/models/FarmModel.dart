class FarmModel {
  String? farmName;
  String? farmAddress;
  double? farmArea;
  String? unit;
  String? farmType;

  FarmModel({
    this.farmName,
    this.farmAddress,
    this.farmArea,
    this.unit,
    this.farmType,
  });

  Map<String, dynamic> toMap() {
    return {
      'farmName': farmName,
      'farmAddress': farmAddress,
      'farmArea': farmArea,
      'unit': unit,
      'farmType': farmType,
    };
  }

  factory FarmModel.fromMap(Map<String, dynamic> map) {
    return FarmModel(
      farmName: map['farmName'],
      farmAddress: map['farmAddress'],
      farmArea: map['farmArea'],
      unit: map['unit'],
      farmType: map['farmType'],
    );
  }
}
