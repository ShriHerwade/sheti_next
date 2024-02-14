import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/AccountModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import '../../common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';
import 'package:sheti_next/zebra/screen/farming/MyFarmScreen.dart';

import '../../common/widgets/NxSnackbar.dart';
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
  String? selectedOwnership;
 late AccountModel account;
  late int accountId;
  DbHelper? dbHelper;
  List<String> units = [];
  List<String> farmOwnership = [];



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

  @override
  Widget build(BuildContext context) {
    // Calculate font size based on screen width
    double fontSize = ResponsiveUtil.fontSize(context, 20.0);

    // Set units and farm types based on the selected language
    if (context.locale.languageCode == 'mr') {
      units = CustomTranslationList.areaUnits_mr;
      farmOwnership = CustomTranslationList.farmOwnership_mr;
    } else if (context.locale.languageCode == 'en') {
      units = CustomTranslationList.areaUnits_en;
      farmOwnership = CustomTranslationList.farmOwnership_en;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.createFarm.tr()),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
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
                      hintText: LocaleKeys.hintFarmName.tr(),
                      labelText: LocaleKeys.labelFarmName.tr(),
                      inputType: TextInputType.name,

                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Text form field for farm address
                    NxTextFormField(
                      controller: _confarmAddress,
                      hintText: LocaleKeys.hintAddress.tr(),
                      labelText: LocaleKeys.labelAddress.tr(),
                      inputType: TextInputType.name,
                      isMandatory: false,
                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Text form field for farm area
                    NxTextFormField(
                      controller: _confarmArea,
                      hintText: LocaleKeys.hintFarmArea.tr(),
                      labelText: LocaleKeys.labelFarmArea.tr(),
                      inputType: TextInputType.number,
                    ),
                    // Spacer
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    // Dropdown form field for selecting unit
                    NxDDFormField(

                      value: selectedUnit,
                      hint: LocaleKeys.hintSelectUnit.tr(),
                      label: LocaleKeys.labelSelectUnit.tr(),
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
                      value: selectedOwnership,
                      label: LocaleKeys.labelSelectFarmType.tr(),
                      hint: LocaleKeys.hintSelectFarmType.tr(),
                      items: farmOwnership,
                      isMandatory: true,
                      isError : false,
                      onChanged: (String? ownershipValue) {
                        setState(() {
                          selectedOwnership = ownershipValue;
                          if (ownershipValue != null) {
                            print('Selected farmOwnership: $ownershipValue');
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
                        onPressed: ()=> saveFarmData(context),
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: TextStyle(
                            color: ColorConstants.textButtonSaveTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
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

  // Check if save button should be enabled


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
          farmType: selectedOwnership!,
          isActive: true,
          createdDate: DateTime.now()
        );

        await dbHelper!.saveFarmData(farm);


        // Clear form fields
        _confarmName.clear();
        _confarmAddress.clear();
        _confarmArea.clear();
        selectedUnit = null;
        selectedOwnership = null;
        NxSnackbar.showSuccess(context, LocaleKeys.messageSaveSuccess.tr(), duration: Duration(seconds: 3));

      }
    } catch (e) {
      print("Error while saving farm : $e");
      NxSnackbar.showError(context, LocaleKeys.messageSaveFailed.tr(), duration: Duration(seconds: 3));
    }
  }
}
