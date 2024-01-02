import 'dart:core';
class CropMetaDataModel {
  int? cropId;
  late String en; //english value
  String? mr; // marathi value
  String? ka; // kannada value
  String? hi; // hindi value
  String? ta; // tamil value
  String? te; // Telugu value
  String? ml; //malayalam value
  String? gu; // Gujarati value
  String? pa; // Punjabi value
  String? es; // Spanish value
  bool isActive;
  late bool isCreatedByUser;
  DateTime? createdDate;

  CropMetaDataModel(
      {this.cropId,
      required this.en,
      this.mr,
      this.ka,
      this.hi,
      this.ta,
      this.te,
      this.ml,
      this.gu,
      this.pa,
      this.es,
      required this.isActive,
      required this.isCreatedByUser,
      this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'cropId': this.cropId,
      'en': this.en,
      'mr': this.mr,
      'ka': this.ka,
      'hi': this.hi,
      'ta': this.ta,
      'te': this.te,
      'ml': this.ml,
      'gu': this.gu,
      'pa': this.pa,
      'es': this.es,
      'isActive': this.isActive ? 1 : 0, // Convert boolean to integer
      'isCreatedByUser': this.isCreatedByUser ? 1 : 0,
      'createdDate': createdDate?.toIso8601String(),
    };
  }

  factory CropMetaDataModel.fromMap(Map<String, dynamic> map) {
    return CropMetaDataModel(
      cropId: map['cropId'] as int,
      en: map['en'] as String,
      mr: map['mr'] as String,
      ka: map['ka'] as String,
      hi: map['hi'] as String,
      ta: map['ta'] as String,
      te: map['te'] as String,
      ml: map['ml'] as String,
      gu: map['gu'] as String,
      pa: map['pa'] as String,
      es: map['es'] as String,
      isActive: map['isActive'] as bool,
      isCreatedByUser: map['isCreatedByUser'] as bool,
      createdDate: map['createdDate'] as DateTime,
    );
  }

// Factory method to create a SettingModel from JSON
  factory CropMetaDataModel.fromJson(Map<String, dynamic> json) {

    try {
      return CropMetaDataModel(
        en: json['en'],
        mr: json['mr'],
        ka: json['ka'],
        hi: json['hi'],
        ta: json['ta'],
        te: json['te'],
        ml: json['ml'],
        gu: json['gu'],
        pa: json['pa'],
        es: json['es'],
        isActive: json['isActive'],
        isCreatedByUser: json['isCreatedByUser'],
        createdDate: json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null,
      );
    }catch (e) {
      print("Error parsing cropsMeta JSON: $e");
      rethrow;  // Re-throw the exception after printing the error
    }
  }
}
