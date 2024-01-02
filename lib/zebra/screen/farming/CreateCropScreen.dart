// create_crop.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import 'package:sheti_next/zebra/screen/farming/MyCropScreen.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';

import '../../common/widgets/NxDDFormField.dart';

class CreateCrop extends StatefulWidget {
  const CreateCrop({Key? key}) : super(key: key);

  @override
  State<CreateCrop> createState() => _CreateCropState();
}

class _CreateCropState extends State<CreateCrop> {
  final _formKey = GlobalKey<FormState>();
  final _confarmArea = TextEditingController();

  String? selectedUnit;
  String? selectedCrop;
  int? selectedFarm;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<String> crops = [];
  List<String> units = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    loadFarms(); // Load farms when the widget initializes
    crops = await dbHelper?.getCropNamesByLanguage(context.locale.languageCode)
    as List<String>;
  }

  // Load farms from the database
  Future<void> loadFarms() async {
    farms = await dbHelper!.getAllFarms();
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }



  @override
  Widget build(BuildContext context) {
    // Initialize ResponsiveUtil with the current context
    double fontSize = ResponsiveUtil.fontSize(context, 20.0);

    // custom list localization
    if (context.locale.languageCode == 'mr') {
      units = CustomTranslationList.areaUnits_mr;
      // crops = CustomTranslationList.crops_mr;
    } else if (context.locale.languageCode == 'en') {
      units = CustomTranslationList.areaUnits_en;
      // crops = CustomTranslationList.crops_en;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.createCrop.tr()),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(ResponsiveUtil.screenWidth(context) * 0.05),
            child: Column(
              children: [
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                Image.asset(
                  "assets/images/top_create-crop-1.png",
                  height: ResponsiveUtil.screenHeight(context) * 0.16,
                  width: ResponsiveUtil.screenWidth(context) * 0.4,
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDDFormField_id(
                  selectedItemId: selectedFarm,
                  label: LocaleKeys.labelFarm.tr(),
                  hint: LocaleKeys.selectFarm.tr(),
                  items: Map.fromIterable(
                    farms,
                    key: (farm) => farm.farmId,
                    value: (farm) => farm.farmName ?? 'Unknown Farm',
                  ),
                  onChanged: (int? farmId) {
                    setState(() {
                      selectedFarm = farmId;
                      if (farmId != null) {
                        print('Selected Farm ID: $farmId');
                      }
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDDFormField(
                  value: selectedCrop,
                  hint: LocaleKeys.selectCrop.tr(),
                  label: LocaleKeys.labelCrop.tr(),
                  items: crops,
                  onChanged: (String? cropName) {
                    setState(() {
                      selectedCrop = cropName;
                      if (cropName != null) {
                        print('Selected Crop: $cropName');
                      }
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxTextFormField(
                  controller: _confarmArea,
                  hintName: LocaleKeys.sowingArea.tr(),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDDFormField(
                  value: selectedUnit,
                  hint: LocaleKeys.selectUnit.tr(),
                  label: LocaleKeys.labelUnit.tr(),
                  items: units,
                  onChanged: (String? unitValue) {
                    setState(() {
                      selectedUnit = unitValue;
                      if (unitValue != null) {
                        print('Selected Unit: $unitValue');
                      }
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDateField(
                  label: LocaleKeys.sowingDate.tr(),
                  labelText: LocaleKeys.sowingDate.tr(),
                  selectedDate: startDate,
                  onTap: (DateTime? picked) {
                    setState(() {
                      startDate = picked;
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDateField(
                  label: LocaleKeys.harvestingDate.tr(),
                  labelText: LocaleKeys.harvestingDate.tr(),
                  selectedDate: endDate,
                  onTap: (DateTime? picked) {
                    setState(() {
                      endDate = picked;
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.35,
                      child: TextButton(
                        onPressed:
                            isSaveButtonEnabled() ? () => saveCropData() : null,
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtil.fontSize(context, 20),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSaveButtonEnabled() ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.35,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyCropScreen(),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.buttonShowAllCrops.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtil.fontSize(context, 20),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isSaveButtonEnabled() {
    return _confarmArea.text.isNotEmpty &&
        selectedFarm != null &&
        selectedCrop != null &&
        selectedUnit != null &&
        startDate != null &&
        endDate != null;
  }

  Future<void> saveCropData() async {
    if (_formKey.currentState!.validate()) {
      try {
        CropModel crop = CropModel(
          farmId: selectedFarm!,
          cropName: selectedCrop!,
          cropVariety: '',
          area: double.parse(_confarmArea.text),
          unit: selectedUnit!,
          startDate: startDate!,
          endDate: endDate!,
          isActive: true,
          createdDate: DateTime.now(),
        );

        await dbHelper!.saveCropData(crop);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Crop data saved successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 16.0)),
        );

        _confarmArea.clear();
        setState(() {
          selectedFarm = null;
          selectedUnit = null;
          selectedCrop = null;
          startDate = null;
          endDate = null;
        });
      } catch (e) {
        print("Error parsing area: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error saving crop data. Please check your input.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 16.0)),
        );
      }
    }
  }
}
