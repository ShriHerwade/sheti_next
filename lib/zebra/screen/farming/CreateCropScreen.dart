import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import 'package:sheti_next/zebra/screen/farming/MyCropScreen.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';

import '../../common/widgets/NxButton.dart';
import '../../common/widgets/NxDDFormField.dart';
import '../../common/widgets/NxSnackbar.dart';
import 'HomeScreen.dart';

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
        centerTitle: false,
        title: Text(LocaleKeys.createCrop.tr()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorConstants.miniIconDefaultColor),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Dismissible(
          key: Key('pageDismissKey'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    MyCropScreen(), // Replace YourNewPage with your actual page
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
                    "assets/images/top_create-crop-1.png",
                    height: ResponsiveUtil.screenHeight(context) * 0.16,
                    width: ResponsiveUtil.screenWidth(context) * 0.4,
                  ),
                  SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                  NxDDFormField_id(
                    selectedItemId: selectedFarm,
                    label: LocaleKeys.labelSelectFarm.tr(),
                    hint: LocaleKeys.hintSelectFarm.tr(),
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
                    hint: LocaleKeys.hintSelectCrop.tr(),
                    label: LocaleKeys.labelSelectCrop.tr(),
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
                    hintText: LocaleKeys.hintSowingArea.tr(),
                    labelText: LocaleKeys.labelSowingArea.tr(),
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
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
                  SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                  NxDateField(

                    label: LocaleKeys.labelSowingDate.tr(),
                    labelText: LocaleKeys.labelSowingDate.tr(),
                    hintText: LocaleKeys.hintSowingDate.tr(),
                    selectedDate: startDate,
                    isMandatory: true,
                    isError: false,
                    onTap: (DateTime? picked) {
                      setState(() {
                        startDate = picked;
                      });
                    },
                  ),
                  SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                  NxDateField(

                    label: LocaleKeys.labelHarvestingDate.tr(),
                    labelText: LocaleKeys.labelHarvestingDate.tr(),
                    hintText: LocaleKeys.hintHarvestingDate.tr(),
                    selectedDate: endDate,
                    isMandatory: true,
                    isError: false,
                    onTap: (DateTime? picked) {
                      setState(() {
                        endDate = picked;
                      });
                    },
                  ),
                  SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                  /*Container(
                    width: ResponsiveUtil.screenWidth(context) * 0.8,
                    child: TextButton(
                      onPressed:
                           () => saveCropData() ,
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
                  ),*/
                  NxButton(buttonText: LocaleKeys.save.tr(),
                    onPressed: ()=> saveCropData() ,
                    width:ResponsiveUtil.screenWidth(context) * 0.8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

        _confarmArea.clear();

        setState(() {
          selectedFarm = null;
          selectedUnit = null;
          selectedCrop = null;
          startDate =null ;
          endDate = null;

          //

        });
        NxSnackbar.showSuccess(context, LocaleKeys.messageSaveSuccess.tr(), duration: Duration(seconds: 3));
      } catch (e) {
        print("Error while saving crop : $e");
        NxSnackbar.showError(context, LocaleKeys.messageSaveFailed.tr(), duration: Duration(seconds: 3));
      }
    }
  }
}


