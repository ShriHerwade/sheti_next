// CreateCrop.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';

class CreateCrop extends StatefulWidget {
  const CreateCrop({Key? key}) : super(key: key);

  @override
  State<CreateCrop> createState() => _CreateCropState();
}

class _CreateCropState extends State<CreateCrop> {
  final _formKey = GlobalKey<FormState>();
  final _confarmArea = TextEditingController();
  final _units = ["Guntha", "Acre", "Hectare"];

  String? selectedUnit;
  String? selectedCrop;
  String? selectedFarm;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;
  List<FarmModel> farms = [];
  List<String> crops = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadFarms(); // Load farms when the widget initializes
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
    // custom list localization
    if (context.locale.languageCode == 'mr') {
      crops = CustomTranslationList.crops_mr;
    } else if (context.locale.languageCode == 'en') {
      crops = CustomTranslationList.crops_en;
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/top_create-crop-1.png",
                  height: 120,
                  width: 150,
                ),
                const SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedFarm,
                  label: LocaleKeys.selectFarm,
                  items: farms.map((FarmModel farm) => farm.farmName ?? 'Unknown Farm').toList(),
                  onChanged: (String? farmName) {
                    setState(() {
                      selectedFarm = farmName;
                      if (farmName != null) {
                        print('Selected Farm: $farmName');
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedCrop,
                  label: LocaleKeys.selectCrop,
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
                SizedBox(height: 20.0),
                NxTextFormField(
                  controller: _confarmArea,
                  hintName: LocaleKeys.sowingArea.tr(),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedUnit,
                  label: LocaleKeys.selectUnit,
                  items: _units,
                  onChanged: (String? unitValue) {
                    setState(() {
                      selectedUnit = unitValue;
                      if (unitValue != null) {
                        print('Selected Unit: $unitValue');
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                buildDateField(LocaleKeys.sowingDate.tr(), startDate, true),
                SizedBox(height: 20.0),
                buildDateField(LocaleKeys.harvestingDate.tr(), endDate, false),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      await saveCropData();
                    },
                    child: Text(
                      LocaleKeys.save.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(
      String label, DateTime? selectedDate, bool isStartDate) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context, isStartDate),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.lightGreen.shade400)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey)),
          fillColor: Colors.white,
          filled: true,
          //label: selectedDate != null ? formatDate(selectedDate) ,
          hintText: selectedDate != null ? formatDate(selectedDate) : label,
          suffixIcon: Icon(Icons.calendar_today),
          border: InputBorder.none,
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }

  Future<void> saveCropData() async {
    if (_formKey.currentState!.validate()) {
      try {
        CropModel crop = CropModel(
          farmName: selectedFarm!,
          cropName: selectedCrop!,
          area: double.parse(_confarmArea.text),
          startDate: startDate!,
          endDate: endDate!,
          isActive: true,
          createdDate: DateTime.now(),
        );

        await dbHelper!.saveCropData(crop);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Crop data saved successfully'),
            duration: Duration(seconds: 2),
          ),
        );

        _confarmArea.clear();
        setState(() {
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
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
