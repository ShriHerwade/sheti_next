import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'FarmsListScreen.dart';

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
  DbHelper? dbHelper;
  List<String> units = [];
  List<String> farmTypes = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'mr') {
      units = CustomTranslationList.areaUnits_mr;
      farmTypes =CustomTranslationList.farmTypes_mr;
    } else if (context.locale.languageCode == 'en') {
      units = CustomTranslationList.areaUnits_en;
      farmTypes =CustomTranslationList.farmTypes_en;;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.createFarm.tr()),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/top_create-farm-1.png",
                  height: 120,
                  width: 150,
                ),
                const SizedBox(height: 20.0),
                NxTextFormField(
                  controller: _confarmName,
                  hintName: LocaleKeys.farmName.tr(),
                  inputType: TextInputType.name,
                ),
                SizedBox(height: 20.0),
                NxTextFormField(
                  controller: _confarmAddress,
                  hintName: LocaleKeys.address.tr(),
                  inputType: TextInputType.name,
                ),
                SizedBox(height: 20.0),
                NxTextFormField(
                  controller: _confarmArea,
                  hintName: LocaleKeys.farmAea.tr(),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedUnit,
                  hint : LocaleKeys.selectUnit.tr(),
                  label : LocaleKeys.labelUnit.tr(),
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
                SizedBox(height: 20.0),
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
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      child: TextButton(
                        onPressed: isSaveButtonEnabled()
                            ? () => saveFarmData(context)
                            : null,
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
                        color:
                        isSaveButtonEnabled() ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FarmsListScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Show Farms",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
    return _confarmName.text.isNotEmpty &&
        _confarmAddress.text.isNotEmpty &&
        _confarmArea.text.isNotEmpty &&
        selectedUnit != null &&
        selectedType != null;
  }

  void saveFarmData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FarmModel farm = FarmModel(
        farmName: _confarmName.text,
        farmAddress: _confarmAddress.text,
        farmArea: double.parse(_confarmArea.text),
        unit: selectedUnit!,
        farmType: selectedType!,
        isActive: true,
        createdDate: DateTime.now(),
      );

      await dbHelper!.saveFarmData(farm);

      _confarmName.clear();
      _confarmAddress.clear();
      _confarmArea.clear();
      selectedUnit = null;
      selectedType = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Farm data saved successfully!"),
        ),
      );
    }
  }
}
