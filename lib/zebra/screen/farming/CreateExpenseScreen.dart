// create_expenseScreen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/screen/farming/MyExpensesScreen.dart';
import '../../common/widgets/NxDDFormField.dart';
import '../../common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';

import '../../dao/models/ExpenseModel.dart';
import 'HomeScreen.dart';

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
  int? userId=1;
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<CropModel> crops = [];
  List<String> farmExpenses = [];
  String? selectedExpense;
 // List<String> selectedExpense = [];
  bool isCreateAnother = false;

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

 /* Future<void> _selectDate(BuildContext context) async {
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
  }*/
// save data
  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

// method to save Record
  void saveExpenseData(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        // Handle save logic using selected values (selectedFarm, selectedCrop, selectedEvent, selectedDate, _confamount.text)
        ExpenseModel expense = ExpenseModel(
          farmId: selectedFarm!,
          cropId: selectedCrop!,
          userId: 1,
         isFarmLevel: false, // Default value
          isCredit: false, // Default value
          creditBy: null, // Default value
          invoiceNumber: null, // Default value
          invoiceFilePath: null, // Default value
          fileExtension: null, // Default value
          splitBetween: 0, // Default value
          details: null, // Default value
          //expenseType: selectedExpense.isNotEmpty ? selectedExpense.first : 'Default Expense', // Default value
          expenseType: selectedExpense!,
          amount: double.parse(_confamount.text),
          expenseDate: selectedDate ?? DateTime.now(),
          isActive: true, // Default value
          createdDate: DateTime.now(), // Default value
        );

        await dbHelper!.saveExpenseData(expense);

        _confamount.clear();
        /*  if(isCreateAnother) {
         //do nothing
        }else{*/
        selectedFarm = null;
        selectedCrop = null;
        isCreateAnother=false;
        selectedExpense = null;

        //selectedExpense = [];
        selectedDate = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  //margin: EdgeInsets.only(right: 2.0),
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: ColorConstants.snackBarSuccessCircleColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: ColorConstants.miniIconDefaultColor,
                    size: 16.0,
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  'Record saved successfully.',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.snackBarTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: ColorConstants.snackBarBackgroundColor,
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving expense data."),
          backgroundColor: ColorConstants.snackBarBackgroundColor,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
        ),
      );
    }
  }

  // Method to get crops by farmId
  Future<void> getCropsByFarmId(int farmId) async {
    if (farmId == null) {
      setState(() {
        crops = []; // Clear the crops list when farmId is null
      });
      return;
    }
    List<CropModel> pulledCrops = await dbHelper!.getCropsByFarmId(farmId);
    // Use the retrieved crops as needed
    print('Crops for Farm ID $farmId: $pulledCrops');
    setState(() {
      crops = pulledCrops;
    });
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
      /*appBar: AppBar(
        title: Text(LocaleKeys.createExpense.tr()),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),*/
      body: Form(
        key: _formKey,
        child:  WillPopScope(
          onWillPop: () async {
            // Navigate to HomeScreen when the back button is pressed
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            // Prevent the default back button behavior
            return false;
          },
          child:  Dismissible(
            key: Key('pageDismissKey'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyExpenses(),
                ),
              );
            },
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
                          selectedCrop = null;
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
                    NxDDFormField(
                      value: selectedExpense,
                      hint: LocaleKeys.selectExpenseType.tr(),
                      label: LocaleKeys.labelExpenseType.tr(),
                      items: farmExpenses,
                      onChanged: (String? expense) {
                        setState(() {
                          selectedExpense = expense;
                          if (expense != null) {
                            print('Selected expenseType: $expense');
                          }
                        });
                      },
                    ),
                    /*SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtil.screenWidth(context) * 0.05),
                      child: DropDownMultiSelect(
                        decoration: InputDecoration(
                          hintText: LocaleKeys.selectExpenseType.tr(),
                          labelText: LocaleKeys.labelExpenseType.tr(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(width:1,color: ColorConstants.enabledFieldBorderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(width: 1,color: ColorConstants.focusedFieldBorderColor)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(width: 1,color: ColorConstants.disabledFieldBorderColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(width: 1,color: ColorConstants.errorFieldBorderColor)),
                          fillColor: ColorConstants.fieldFillDefaultColor,
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
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal, color: ColorConstants.fieldHintTextColor),
                      ),
                    ),*/
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    buildDateField(LocaleKeys.expenseDate.tr()),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxTextFormField(
                      controller: _confamount,
                      hintName: LocaleKeys.expenseAmount.tr(),
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    CheckboxListTile(

                      checkColor: ColorConstants.checkBoxColor.withOpacity(0.9),
                      activeColor: ColorConstants.checkBoxActiveColor,
                      title:Text("Create Another Expense"),
                      value: this.isCreateAnother,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          this.isCreateAnother = value!;
                        });
                      },
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.8,
                      child: TextButton(
                        onPressed: isSaveButtonEnabled()
                            ? () => saveExpenseData(context)
                            : null,
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: TextStyle(
                            color: ColorConstants.textButtonSaveTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtil.fontSize(context, 20),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.textButtonSaveColor,
                        //isSaveButtonEnabled() ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
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
       // selectedExpense?.isNotEmpty &&
        selectedDate != null &&
        _confamount.text.isNotEmpty;
  }

  void showExpenses() {
    // Implement logic to navigate or show expenses screen
   Navigator.push(
       context,MaterialPageRoute(builder: (_) => MyExpenses()));
    // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => ExpensesScreen()));
  }
}
