// create_events.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField_id.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/screen/farming/MyEventsScreen.dart';
import '../../dao/models/EventModel.dart';
import '../../dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/common/widgets/NxDateField.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';

import 'HomeScreen.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({Key? key}) : super(key: key);

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  final _formKey = GlobalKey<FormState>();
  DbHelper? dbHelper;

  int? selectedFarm;
  int? selectedCrop;
  String? multiHint;
  DateTime? startDate;
  DateTime? endDate;

  List<FarmModel> farms = [];
  List<CropModel> crops = [];
  List<String> farmEvents = [];
  List<String> selectedFarmEvents = [];
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

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

  Future<void> getCropsByFarmId(int? farmId) async {
    if (farmId == null) {
      setState(() {
        crops = []; // Clear the crops list when farmId is null
      });
      return;
    }
    List<CropModel> pulledCrops = await dbHelper!.getCropsByFarmId(farmId);
    print('Crops for Farm ID $farmId: $pulledCrops');
    setState(() {
      crops = pulledCrops;
    });
  }

  Future<void> saveRecords() async {
    if (_formKey.currentState!.validate()) {
      if (selectedFarm != null &&
          selectedCrop != null &&
          startDate != null &&
          endDate != null &&
          selectedFarmEvents.isNotEmpty) {
        EventModel event = EventModel(
          userId: 1,
          farmId: selectedFarm!,
          cropId: selectedCrop!,
          eventType: selectedFarmEvents.join(", "),
          startDate: startDate!,
          endDate: endDate!,
          notes: null,
          isDone: false,
          isActive: true,
          createdDate: DateTime.now(),
        );

        await dbHelper!.saveEventData(event);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
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
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
          ),
        );


          selectedFarm = null;
          selectedCrop = null;
          isCreateAnother=false;
        selectedFarmEvents = [];
        startDate = null;
        endDate = null;

        _formKey.currentState!.reset();
      } else {
        print("Please fill in all fields.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'mr') {
      farmEvents = CustomTranslationList.farmEvents_mr;
    } else if (context.locale.languageCode == 'en') {
      farmEvents = CustomTranslationList.farmEvents_en;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.createEvent.tr()),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            return false;
          },
          child:  Dismissible(
            key: Key('pageDismissKey'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyEvents(),
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
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
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
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtil.screenWidth(context) * 0.05),
                      child: DropDownMultiSelect(
                        decoration: InputDecoration(
                          hintText: LocaleKeys.hintSelectEvent.tr(),
                          labelText: LocaleKeys.labelSelectEvent.tr(),
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
                        onChanged: (List<String> ev) {
                          setState(() {
                            selectedFarmEvents = ev;
                          });
                        },
                        options: farmEvents,
                        selectedValues: selectedFarmEvents,
                        hint: Text(LocaleKeys.hintSelectEvent.tr()),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxDateField(
                      label: LocaleKeys.labelEventStartDate.tr(),
                      labelText: LocaleKeys.labelEventStartDate.tr(),
                      selectedDate: startDate,
                      onTap: (DateTime? picked) {
                        setState(() {
                          startDate = picked;
                        });
                      },
                    ),
                    SizedBox(
                        height: ResponsiveUtil.screenHeight(context) * 0.02),
                    NxDateField(
                      label: LocaleKeys.labelEventEndDate.tr(),
                      labelText: LocaleKeys.hintEventEndDate.tr(),
                      selectedDate: endDate,
                      onTap: (DateTime? picked) {
                        setState(() {
                          endDate = picked;
                        });
                      },
                    ),
                    SizedBox(
                        height: ResponsiveUtil.screenHeight(context) * 0.02),
                    Container(
                      width: ResponsiveUtil.screenWidth(context) * 0.8,
                      child: TextButton(
                        onPressed: saveRecords,
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
}
