
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/AccountModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../../common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmScreen.dart';
class CreateFarms extends StatefulWidget {
  const CreateFarms({Key? key}) : super(key: key);

  @override
  State<CreateFarms> createState() => _CreateFarmsState();
}

class _CreateFarmsState extends State<CreateFarms> {

  final _formKey = GlobalKey<FormState>();
  final _confarmName = TextEditingController();
  final _confarmAddress = TextEditingController();
  final _confarmArea = TextEditingController();

  String? selectedUnit;
  String? selectedType;
 late AccountModel account;
  late int accountId;
  DbHelper? dbHelper;
  List<String> units = [];
  List<String> farmTypes = [];



  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    _loadActiveAccount();
  }

  void _loadActiveAccount() async {
    AccountModel? activeAccount = await dbHelper?.getActiveAccount();
    if (activeAccount != null) {
      setState(() {
        account = activeAccount;
        accountId = activeAccount.accountId!;
      });
    } else {
      // Handle the case where no active account is found
    }
  }

  void _handleInsertInitialMetaData() async {
    Database? db = await dbHelper?.db;
    if (db != null) {
      await dbHelper?.insertInitialMetaData(db);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate font size based on screen width
    double fontSize = ResponsiveUtil.fontSize(context, 20.0);

    // Set units and farm types based on the selected language
    if (context.locale.languageCode == 'mr') {
      units = CustomTranslationList.areaUnits_mr;
      farmTypes = CustomTranslationList.farmTypes_mr;
    } else if (context.locale.languageCode == 'en') {
      units = CustomTranslationList.areaUnits_en;
      farmTypes = CustomTranslationList.farmTypes_en;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.createFarm.tr()),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: WillPopScope(
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
                  builder: (context) => MyFarmScreen(),
                ),
              );
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(ResponsiveUtil.screenWidth(context) * 0.05),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // Responsive image
                    Image.asset(
                      "assets/images/top_create-farm-1.png",
                      height: ResponsiveUtil.screenHeight(context) * 0.16,
                      width: ResponsiveUtil.screenWidth(context) * 0.4,
                    ),
                    // Spacer
                     SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.04),
                    // Text form field for farm name
                    NxTextFormField(
                      controller: _confarmName,
                      hintName: LocaleKeys.farmName.tr(),
                      inputType: TextInputType.name,
                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Text form field for farm address
                    NxTextFormField(
                      controller: _confarmAddress,
                      hintName: LocaleKeys.address.tr(),
                      inputType: TextInputType.name,

                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Text form field for farm area
                    NxTextFormField(
                      controller: _confarmArea,
                      hintName: LocaleKeys.farmAea.tr(),
                      inputType: TextInputType.number,
                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Dropdown form field for selecting unit
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
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Dropdown form field for selecting farm type
                    NxDDFormField(
                      value: selectedType,
                      label: LocaleKeys.labelFarmType.tr(),
                      hint: LocaleKeys.selectFarmType.tr(),
                      items: farmTypes,
                      onChanged: (String? typeValue) {
                        setState(() {
                          selectedType = typeValue;
                          if (typeValue != null) {
                            print('Selected Type: $typeValue');
                          }
                        });
                      },
                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.01),
                    // Row with two buttons
                    Container(
                     width: ResponsiveUtil.screenWidth(context) * 0.8,
                      child: TextButton(
                        onPressed: isSaveButtonEnabled()
                            ? () => saveFarmData(context)
                            : null,
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ec45d),
                        //isSaveButtonEnabled() ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Show all farms button
                    /*Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.35,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyFarmScreen(),
                            ),
                          );
                        },
                        *//*child: Text(
                          LocaleKeys.buttonShowAllFarms.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),*//*
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),*/
                    GestureDetector(
                      onTap: _handleInsertInitialMetaData,
                      child: Text.rich(
                        TextSpan(
                          text: 'L',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),
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

  // Check if save button should be enabled
  bool isSaveButtonEnabled() {
    return _confarmName.text.isNotEmpty &&
        _confarmAddress.text.isNotEmpty &&
        _confarmArea.text.isNotEmpty &&
        selectedUnit != null &&
        selectedType != null;
  }

  // Save farm data to the database
  void saveFarmData(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        FarmModel farm = FarmModel(
          accountId: 1,
          farmName: _confarmName.text,
          farmAddress: _confarmAddress.text,
          farmArea: double.parse(_confarmArea.text),
          unit: selectedUnit!,
          farmType: selectedType!,
          isActive: true,
          createdDate: DateTime.now()
        );

        await dbHelper!.saveFarmData(farm);

        // Clear form fields
        _confarmName.clear();
        _confarmAddress.clear();
        _confarmArea.clear();
        selectedUnit = null;
        selectedType = null;

        // Show a success message in green
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  //margin: EdgeInsets.only(right: 2.0),
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  'Record saved successfully.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: Colors.black,
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
      // Show an error message in red
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving farm data. Please try again."),
          backgroundColor: Colors.black,
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
}
