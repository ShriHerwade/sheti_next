import 'package:flutter/material.dart';
import '../../common/util/CustomTranslationList.dart';
import '../../common/widgets/NxButton.dart';
import '../../common/widgets/NxDDFormField.dart';
import '../../common/widgets/NxSnackbar.dart';
import '../../common/widgets/NxTextFormField.dart';
import '../../dao/DbHelper.dart';
import '../../dao/models/FarmModel.dart';
import 'HomeScreen.dart';

class ModifyFarmScreen extends StatefulWidget {
  final FarmModel farm;

  const ModifyFarmScreen({Key? key, required this.farm}) : super(key: key);

  @override
  _ModifyFarmScreenState createState() => _ModifyFarmScreenState();
}

class _ModifyFarmScreenState extends State<ModifyFarmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmNameController = TextEditingController();
  final _farmAddressController = TextEditingController();
  final _farmAreaController = TextEditingController();

  String? selectedUnit;
  String? selectedOwnership;

  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();

    // Populate form fields with existing farm data
    _farmNameController.text = widget.farm.farmName ?? '';
    _farmAddressController.text = widget.farm.farmAddress ?? '';
    _farmAreaController.text = widget.farm.farmArea.toString();
    selectedUnit = widget.farm.unit;
    selectedOwnership = widget.farm.farmType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Farm'),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxTextFormField(
                controller: _farmNameController,
                hintText: 'Farm Name',
                labelText: 'Farm Name',
                inputType: TextInputType.name,
              ),
              SizedBox(height: 20.0),
              NxTextFormField(
                controller: _farmAddressController,
                hintText: 'Address',
                labelText: 'Address',
                inputType: TextInputType.streetAddress,
              ),
              SizedBox(height: 20.0),
              NxTextFormField(
                controller: _farmAreaController,
                hintText: 'Farm Area',
                labelText: 'Farm Area',
                inputType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              NxDDFormField(
                value: selectedUnit,
                hint: 'Select Unit',
                label: 'Unit',
                items: CustomTranslationList.areaUnits_en,
                onChanged: (String? unitValue) {
                  setState(() {
                    selectedUnit = unitValue;
                  });
                },
              ),
              SizedBox(height: 20.0),
              NxDDFormField(
                value: selectedOwnership,
                label: 'Farm Type',
                hint: 'Select Farm Type',
                items: CustomTranslationList.farmOwnership_en,
                onChanged: (String? ownershipValue) {
                  setState(() {
                    selectedOwnership = ownershipValue;
                  });
                },
              ),
              SizedBox(height: 20.0),
              NxButton(
                buttonText: 'Modify Farm',
                onPressed: () => modifyFarmData(context), width: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void modifyFarmData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Extract data from form fields
      String farmName = _farmNameController.text;
      String farmAddress = _farmAddressController.text;
      double farmArea = double.parse(_farmAreaController.text);

      // Update farm model
      FarmModel updatedFarm = FarmModel(
        farmId: widget.farm.farmId, // Assuming farmId is the unique identifier
        accountId: widget.farm.accountId,
        farmName: farmName,
        farmAddress: farmAddress,
        farmArea: farmArea,
        unit: selectedUnit!,
        farmType: selectedOwnership!,
        isActive: true,
        isExpanded: true,
        createdDate: widget.farm.createdDate,
      );

      // Update farm record in the database
      await dbHelper.updateFarmData(updatedFarm);

      // Show success message
      NxSnackbar.showSuccess(context, 'Farm updated successfully');

      // Navigate back to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }
}
