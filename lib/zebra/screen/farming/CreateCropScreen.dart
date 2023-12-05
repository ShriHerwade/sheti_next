import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheti_next/zebra/common/widgets/NxTextFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart'; // Import the FarmModel
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
class CreateCrop extends StatefulWidget {
  const CreateCrop({Key? key}) : super(key: key);

  @override
  State<CreateCrop> createState() => _CreateCropState();
}

class _CreateCropState extends State<CreateCrop> {
  final _formKey = GlobalKey<FormState>();
  final _concropName = TextEditingController();
  final _confarmArea = TextEditingController();
  final _cropNames = ["ऊस - 80032", "ऊस - 80011", "ज्वारी - शाळू", "ज्वारी - हायब्रीड"];
  final _unit = ["एकर", "हेक्टर"];

  String? selectedUnit;
  String? selectedCrop;
  DateTime? startDate;
  DateTime? endDate;
  DbHelper? dbHelper;
  List<FarmModel> farms = []; // List to store farms

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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create New Crop"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Image.asset(
                          "assets/images/top_create-crop-1.png",
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedUnit,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Farm Name'),
                        ),
                        onChanged: (String? farmName) {
                          setState(() {
                            selectedUnit = farmName;
                            if (farmName != null) {
                              print('Selected Farm: $farmName');
                            }
                          });
                        },
                        items: farms.map((FarmModel farm) {
                          return DropdownMenuItem<String>(
                            value: farm.farmName,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(farm.farmName ?? 'Unknown Farm'),

                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCrop,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text('Select Crop'),
                        ),
                        onChanged: (String? cropName) {
                          setState(() {
                            selectedCrop = cropName;
                            if (cropName != null) {
                              print('Selected Crop: $cropName');
                            }
                          });
                        },
                        items: _cropNames.map((String crop) {
                          return DropdownMenuItem<String>(
                            value: crop,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(crop),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  NxTextFormField(
                    controller: _confarmArea,
                    hintName: "Area",
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  buildDateField("Start Date", startDate, true),
                  SizedBox(height: 20.0),
                  buildDateField("End Date", endDate, false),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Handle save logic using selected dates (startDate and endDate)
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0),
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

  Widget buildDateField(String label, DateTime? selectedDate, bool isStartDate) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context, isStartDate),
        decoration: InputDecoration(
          hintText: selectedDate != null ? formatDate(selectedDate) : label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }
}
