// create_expenses.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import '../../common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';

class CreateExpenses extends StatefulWidget {
  const CreateExpenses({Key? key});

  @override
  State<CreateExpenses> createState() => _CreateExpensesState();
}

class _CreateExpensesState extends State<CreateExpenses> {
  final _formKey = GlobalKey<FormState>();
  final _confamount = TextEditingController();

  int? selectedFarm;
  int? selectedCrop;
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<CropModel> crops = [];
  List<String> farmExpenses = [];
  List<String> selectedExpense = [];

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
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

  // Method to get crops by farmId
  Future<void> getCropsByFarmId(int farmId) async {
    List<CropModel> crops = await dbHelper!.getCropsByFarmId(farmId);
    // Use the retrieved crops as needed
    print('Crops for Farm ID $farmId: $crops');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'mr') {
      //crops = CustomTranslationList.crops_mr;
      farmExpenses = CustomTranslationList.farmEvents_mr;
    } else if (context.locale.languageCode == 'en') {
      //crops = CustomTranslationList.crops_en;
      farmExpenses = CustomTranslationList.farmEvents_en;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(LocaleKeys.createExpense.tr()),
        centerTitle: true,
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
                  "assets/images/top_create-life-cycle-event-2.png",
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
                        getCropsByFarmId(farmId);

                      }
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxDDFormField_id(
                  selectedItemId: selectedCrop,
                  hint: LocaleKeys.selectCrop.tr(),
                  label: LocaleKeys.labelCrop.tr(),
                  items: Map.fromIterable(
                    crops,
                    key: (crop) => crop.cropId,
                    value: (crop) => crop.cropName ?? 'Unknown Crop',
                  ),
                  onChanged: (int? cropId) {
                    setState(() {
                      selectedCrop = cropId;
                      if (cropId != null) {
                        print('Selected Crop ID: $cropId');
                      }
                    });
                  },
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.screenWidth(context) * 0.05),
                  child: DropDownMultiSelect(
                    decoration: InputDecoration(
                      hintText: LocaleKeys.selectExpenseType.tr(),
                      labelText: LocaleKeys.labelExpenseType.tr(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.lightGreen.shade400),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                    ),
                    onChanged: (List<String> ex) {
                      setState(() {
                        selectedExpense = ex;
                      });
                    },
                    options: farmExpenses,
                    selectedValues: selectedExpense,
                    hint: Text(LocaleKeys.selectExpenseType.tr()),
                    hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                buildDateField(LocaleKeys.expenseDate.tr()),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                NxTextFormField(
                  controller: _confamount,
                  hintName: LocaleKeys.expenseAmount.tr(),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                Container(
                  margin: EdgeInsets.all(ResponsiveUtil.screenWidth(context) * 0.1),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isSaveButtonEnabled()
                        ? () => saveExpenseData(context)
                        : null,
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
                    color: isSaveButtonEnabled() ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(String label) {
    return NxDateField(
      label: label,
      labelText: label,
      selectedDate: selectedDate,
      onTap: (DateTime? picked) {
        setState(() {
          selectedDate = picked;
        });
      },
    );
  }

  bool isSaveButtonEnabled() {
    return selectedFarm != null &&
        selectedCrop != null &&
        selectedExpense.isNotEmpty &&
        selectedDate != null &&
        _confamount.text.isNotEmpty;
  }

  void saveExpenseData(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        // Handle save logic using selected values (selectedFarm, selectedCrop, selectedEvent, selectedDate, _confamount.text)

        _confamount.clear();
        selectedFarm = null;
        selectedCrop = null;
        selectedExpense = [];
        selectedDate = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense data saved successfully!"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 16.0)
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving expense data. Please try again."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 16.0),
        ),
      );
    }
  }
}
