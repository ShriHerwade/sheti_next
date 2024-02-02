import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/PoeModel.dart';
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
  final _confAmount = TextEditingController();
  final _confNotes = TextEditingController();
  final _confBillNumber = TextEditingController();

  int? selectedFarm;
  int? selectedCrop;
  int? selectedPoe;
  int? userId=1;
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<CropModel> crops = [];
  List<String> farmExpenseTypes = [];
  List<String> farmExpenseSubTypes = [];
  List<PoeModel> poes = [];

  String? selectedExpenseType;
  String? selectedExpenseSubType;
  bool isCreditExpense = false;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadFarms(); // Load farms when the widget initializes
    loadCreditors();
  }

  // Load farms from the database
  Future<void> loadFarms() async {
    farms = await dbHelper!.getAllFarms();
    setState(() {});
  }

  Future<void> loadCreditors() async {
    poes = await dbHelper!.getAllPoe();
    setState(() {});
  }


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
          poeId: selectedPoe, // Default value
          invoiceNumber: _confBillNumber.text, // Default value
          invoiceFilePath: null, // Default value
          fileExtension: null, // Default value
          splitBetween: 0, // Default value
          notes: _confNotes.text, // Default value
          //expenseType: selectedExpense.isNotEmpty ? selectedExpense.first : 'Default Expense', // Default value
          expenseType: (selectedExpenseType! + (selectedExpenseSubType ?? '')),
          amount: double.parse(_confAmount.text),
          expenseDate: selectedDate ?? DateTime.now(),
          isActive: true, // Default value
          createdDate: DateTime.now(), // Default value
        );

        await dbHelper!.saveExpenseData(expense);

        _confAmount.clear();
        selectedFarm = null;
        selectedCrop = null;
        isCreditExpense = false;
        selectedExpenseType = null;
        selectedExpenseSubType = null;

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
      farmExpenseTypes = CustomTranslationList.farmExpenses_mr;
      farmExpenseSubTypes = CustomTranslationList.farmExpenseSubType_mr;
    } else if (context.locale.languageCode == 'en') {
      //crops = CustomTranslationList.crops_en;
      farmExpenseTypes = CustomTranslationList.farmExpenses_en;
      farmExpenseSubTypes = CustomTranslationList.farmExpenseSubType_en;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,

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
                    /*SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Image.asset(
                      "assets/images/top_create-life-cycle-event-2.png",
                      height: ResponsiveUtil.screenHeight(context) * 0.16,
                      width: ResponsiveUtil.screenWidth(context) * 0.4,
                    ),*/
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
                      value: selectedExpenseType,
                      hint: LocaleKeys.selectExpenseType.tr(),
                      label: LocaleKeys.labelExpenseType.tr(),
                      items: farmExpenseTypes,
                      onChanged: (String? expenseType) {
                        setState(() {
                          selectedExpenseType = expenseType;
                          if (expenseType != null) {
                            print('Selected expenseType: $expenseType');
                          }
                        });
                      },
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxDDFormField(
                      value: selectedExpenseSubType,
                      hint: LocaleKeys.selectExpenseSubType.tr(),
                      label: LocaleKeys.labelExpenseSubType.tr(),
                      items: farmExpenseSubTypes,
                      onChanged: (String? expenseSubType) {
                        setState(() {
                          selectedExpenseSubType = expenseSubType;
                          if (expenseSubType != null) {
                            print('Selected expenseSubType: $expenseSubType');
                          }
                        });
                      },
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Checkbox(
                            checkColor: ColorConstants.checkBoxColor.withOpacity(0.9),
                            activeColor: ColorConstants.checkBoxActiveColor,
                            value: this.isCreditExpense,
                            onChanged: (bool? value) {
                              setState(() {
                                this.isCreditExpense = value!;
                              });
                            },
                          ),
                        ),
                        Text(LocaleKeys.checkBoxIsCreditor.tr(),),

                        TextButton(
                          onPressed: () {
                            // Open the dialog to add a new creditor
                            _showAddCreditorDialog();
                          },
                          child: Text(
                            '+ Add New Creditor',
                            style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxDDFormField_id(
                      selectedItemId: selectedPoe,
                      label: LocaleKeys.labelCreditor.tr(),
                      hint: LocaleKeys.hintCreditor.tr(),
                      items: Map.fromIterable(
                        poes,
                        key: (poe) => poe.poeId,
                        value: (poe) => poe.poeName ?? 'Unknown Poe',
                      ),
                      onChanged: (int? poeId) {
                        setState(() {
                          selectedPoe = poeId;
                          if (poeId != null) {
                            print('Selected Poe ID: $poeId');
                          }
                        });
                      },
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxTextFormField(
                      controller: _confBillNumber,
                      hintText: LocaleKeys.HintBillNumber.tr(),
                      inputType: TextInputType.text,
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    buildDateField(LocaleKeys.expenseDate.tr()),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxTextFormField(
                      controller: _confAmount,
                      hintText: LocaleKeys.expenseAmount.tr(),
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxTextFormField(
                      controller: _confNotes,
                      hintText: LocaleKeys.labelNotes.tr(),
                      inputType: TextInputType.text,
                      maxLines : 2,
                      expands : false
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.8,
                      child: TextButton(
                        onPressed: () => saveExpenseData(context),
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

  Widget buildCreditorDropdown() {
    return Stack(
      children: [
        NxDDFormField_id(
          selectedItemId: selectedPoe,
          label: LocaleKeys.labelCreditor.tr(),
          hint: LocaleKeys.hintCreditor.tr(),
          items: Map.fromIterable(
            poes,
            key: (poe) => poe.poeId,
            value: (poe) => poe.poeName ?? 'Unknown Poe',
          ),
          onChanged: (int? poeId) {
            setState(() {
              selectedPoe = poeId;
              if (poeId != null) {
                print('Selected Farm ID: $poeId');
              }
            });
          },
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: isCreditExpense ? _showAddCreditorDialog : null,
          ),
        ),
      ],
    );
  }

  void _showAddCreditorDialog() {
    String poeName = "";
    String poeMobileNo = "";
    String poeAddress = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Creditor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => poeName = value,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) => poeMobileNo = value,
                decoration: InputDecoration(labelText: 'Mobile'),
              ),
              TextField(
                onChanged: (value) => poeAddress = value,
                decoration: InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
               dbHelper!.savePoeData(PoeModel(
                   poeName: poeName,
                   accountId: 1, //hard coded need to replace with global variable
                   mobileNo: poeMobileNo,
                   address: poeAddress,
                   email : null,
                   isCreditor : true,
                   isShopFirm : true,
                   isBuyer : false,
                   isServiceProvider : false,
                   isFarmWorker : false,
                   isActive : true,
               ));
               await loadCreditors();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  void showExpenses() {
    // Implement logic to navigate or show expenses screen
    Navigator.push(
        context,MaterialPageRoute(builder: (_) => MyExpenses()));
    // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => ExpensesScreen()));
  }
}
