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
import '../../common/widgets/NxDDFormField.dart';
import '../../common/widgets/NxSnackbar.dart';
import '../../common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import '../../dao/models/IncomeModel.dart';

class CreateIncomeScreen extends StatefulWidget {
  const CreateIncomeScreen({Key? key});

  @override
  State<CreateIncomeScreen> createState() => _CreateIncomeScreenState();
}

class _CreateIncomeScreenState extends State<CreateIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confAmount = TextEditingController();
  final _confQuantity = TextEditingController();
  final _confRate = TextEditingController();
  final _confNotes = TextEditingController();
  final _confReceiptNumber = TextEditingController();
  final _confBuyersName = TextEditingController();

  int? selectedFarm;
  int? selectedCrop;
  int? userId = 1;
  double? quantity;
  String? selectedRateUnit;//selected unit for rate
  String? selectedQuantityUnit;
  DateTime? selectedDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<CropModel> crops = [];
  List<String> farmIncomes = [];
  List<PoeModel> poes = [];
  List<String> cropUnit = [];

  String? selectedIncomeType;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadFarms(); // Load farms when the widget initializes
    //loadPoes(); // Load poes when the widget initializes
  }

  // Load farms from the database
  Future<void> loadFarms() async {
    farms = await dbHelper!.getAllFarms();
    setState(() {});
  }

  Future<void> loadPoes() async {
    poes = await dbHelper!.getAllPoe();
    setState(() {});
  }

  // Save data
  void saveIncomeData(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        // Handle save logic using selected values (selectedFarm, selectedCrop, selectedIncome, selectedDate, _confamount.text)
        IncomeModel income = IncomeModel(
          farmId: selectedFarm!,
          cropId: selectedCrop!,
          userId: 1,
          ratePerUnit: double.parse(_confRate.text),
          rateUnit: selectedRateUnit,
          quantity: double.parse(_confQuantity.text),
          unit: selectedQuantityUnit!,
          incomeType: selectedIncomeType!,
          buyersName: _confBuyersName.text,
          amount: double.parse(_confAmount.text),
          incomeDate: selectedDate ?? DateTime.now(),
          notes: _confNotes.text,
          isActive: true, // Default value
          createdDate: DateTime.now(), // Default value
        );

        await dbHelper!.saveIncomeData(income);

        _confAmount.clear();
        _confQuantity.clear();
        _confRate.clear();
        _confBuyersName.clear();
        selectedFarm = null;
        selectedCrop = null;
        selectedIncomeType = null;
        selectedDate = null;
        NxSnackbar.showSuccess(context, LocaleKeys.messageSaveSuccess.tr(), duration: Duration(seconds: 3));
      }
    } catch (e) {
      print("Error while saving income : $e");
      NxSnackbar.showError(context, LocaleKeys.messageSaveFailed.tr(), duration: Duration(seconds: 3));
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
      farmIncomes = CustomTranslationList.incomeType_mr;
      cropUnit = CustomTranslationList.cropUnits_mr;
    } else if (context.locale.languageCode == 'en') {
      farmIncomes = CustomTranslationList.incomeType_en;
      cropUnit = CustomTranslationList.cropUnits_en;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Form(
        key: _formKey,
        child: WillPopScope(
          onWillPop: () async {
            // Navigate to MyIncomesScreen when the back button is pressed
            /*Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyIncomesScreen()));*/
            // Prevent the default back button behavior
            return false;
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Add your image widget here
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
                        selectedCrop = null;
                        if (farmId != null) {
                          print('Selected Farm ID: $farmId');
                          getCropsByFarmId(farmId);
                        }
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxDDFormField_id(
                    selectedItemId: selectedCrop,
                    hint: LocaleKeys.hintSelectCrop.tr(),
                    label: LocaleKeys.labelSelectCrop.tr(),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxDDFormField(
                    value: selectedIncomeType,
                    hint: LocaleKeys.hintSelectIncomeType.tr(),
                    label: LocaleKeys.labelSelectIncomeType.tr(),
                    items: farmIncomes,
                    onChanged: (String? income) {
                      setState(() {
                        selectedIncomeType = income;
                        if (income != null) {
                          print('Selected incomeType: $income');
                        }
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Rate Per Unit
                      Expanded(
                        child: NxTextFormField(
                          controller: _confRate,
                          labelText:LocaleKeys.hintRatePerUnit.tr(),
                          hintText: LocaleKeys.labelRatePerUnit.tr(),
                          inputType: TextInputType.number,
                          padding : EdgeInsets.only(left:  20.0),
                          isMandatory: false,
                          isError : false,
                        ),
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      // Unit
                      Expanded(
                        child: NxDDFormField(
                          value: selectedRateUnit,
                          hint: LocaleKeys.hintRatePerUnit.tr(),
                          label: LocaleKeys.labelRatePerUnit.tr(),
                          items: cropUnit,
                          padding: EdgeInsets.only(right: 20),
                          isMandatory: false,
                          isError : false,
                          onChanged: (String? rateUnit) {
                            setState(() {
                              selectedRateUnit = rateUnit;
                              if (rateUnit != null) {
                                print('Selected Rate Unit: $rateUnit');
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: NxTextFormField(
                          controller: _confQuantity,
                          labelText:LocaleKeys.labelQuantitySold.tr(),
                          hintText: LocaleKeys.hintQuantitySold.tr(),
                          inputType: TextInputType.number,
                          padding : EdgeInsets.only(left:  20.0),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                        child: NxDDFormField(
                          value: selectedQuantityUnit,
                          hint: LocaleKeys.hintSelectQuantityUnit.tr(),
                          label: LocaleKeys.labelSelectQuantityUnit.tr(),
                          items: cropUnit,
                          padding: EdgeInsets.only(right: 20),
                          onChanged: (String? quantityUnit) {
                            setState(() {
                              selectedQuantityUnit = quantityUnit!;
                              if (quantityUnit != null) {
                                print('Selected Quantity Unit: $quantityUnit');
                              }
                            });
                          },
                        ),
                      )
                      // Quantity Sold

                      //SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      // Quantity Unit

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxTextFormField(
                    controller: _confBuyersName,
                    hintText: LocaleKeys.hintBuyersName.tr(),
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxTextFormField(
                    controller: _confReceiptNumber,
                    hintText: LocaleKeys.hintReceiptNumber.tr(),
                    labelText: LocaleKeys.labelReceiptNumber.tr(),
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  buildDateField(LocaleKeys.labelIncomeDate.tr(),LocaleKeys.hintIncomeDate.tr()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxTextFormField(
                    controller: _confAmount,
                    hintText: LocaleKeys.hintAmountReceived.tr(),
                    labelText: LocaleKeys.labelAmountReceived.tr(),
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NxTextFormField(
                      controller: _confNotes,
                      hintText: LocaleKeys.labelNotes.tr(),
                      labelText: LocaleKeys.hintNotes.tr(),
                      inputType: TextInputType.text,
                      maxLines : 2,
                      expands : false,
                      isMandatory: false,
                      isError : false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      onPressed: () => saveIncomeData(context),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(
                          color: ColorConstants.textButtonSaveTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.textButtonSaveColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(String label,String hint) {
    return NxDateField(
      label: label,
      labelText: label,
      hintText: hint,
      selectedDate: selectedDate,
      isMandatory: true,
      isError : false,
      onTap: (DateTime? picked) {
        setState(() {
          selectedDate = picked;
        });
      },
    );
  }
}