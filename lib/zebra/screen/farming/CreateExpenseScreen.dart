import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sheti_next/translations/locale_keys.g.dart';
import 'package:sheti_next/zebra/common/util/CustomTranslationList.dart';
import 'package:sheti_next/zebra/common/widgets/NxDDFormField.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import '../../common/widgets/NxTextFormField.dart';

class CreateExpenses extends StatefulWidget {
  const CreateExpenses({Key? key});

  @override
  State<CreateExpenses> createState() => _CreateExpensesState();
}

class _CreateExpensesState extends State<CreateExpenses> {
  final _formKey = GlobalKey<FormState>();
  final _confamount = TextEditingController();

  String? selectedFarm;
  String? selectedCrop;
  DateTime? selectedDate;
  DbHelper? dbHelper;

  List<FarmModel> farms = [];
  List<String> crops = [];
  List<String> farmExpenses = [];
  List<String> selectedExpense= [];

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

  Future<void> _selectDate(BuildContext context) async {
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
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return '';
    }
  }

  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'mr') {
      crops = CustomTranslationList.crops_mr;
      farmExpenses = CustomTranslationList.farmEvents_mr;
    } else if (context.locale.languageCode == 'en') {
      crops = CustomTranslationList.crops_en;
      farmExpenses = CustomTranslationList.farmEvents_en;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(LocaleKeys.createExpense.tr()),
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
                  "assets/images/top_create-life-cycle-event-2.png",
                  height: 120,
                  width: 150,
                ),
                const SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedFarm,
                  label: LocaleKeys.selectFarm,
                  items: farms.map((farm) => farm.farmName ?? 'Unknown Farm').toList(),
                  onChanged: (String? farmName) {
                    setState(() {
                      selectedFarm = farmName;
                      if (farmName != null) {
                        print('Selected Farm: $farmName');
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                NxDDFormField(
                  value: selectedCrop,
                  label: LocaleKeys.selectCrop,
                  items: crops,
                  onChanged: (String? cropName) {
                    setState(() {
                      selectedCrop = cropName;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                DropDownMultiSelect(
                  onChanged: (List<String> ex) {
                    setState(() {
                      selectedExpense =ex;
                    });
                  },
                  options: farmExpenses,
                  selectedValues: selectedExpense,
                  //whenEmpty: 'Select Expense Type',
                  hint: Text(LocaleKeys.selectExpenseType.tr()),
                ),
                SizedBox(height: 20.0),
                buildDateField(LocaleKeys.expenseDate.tr()),
                SizedBox(height: 20.0),
                NxTextFormField(
                  controller: _confamount,
                  hintName: LocaleKeys.expenseAmount.tr(),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isSaveButtonEnabled()
                        ? () => saveExpenseData(context)
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
                    color: isSaveButtonEnabled() ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.lightGreen.shade400),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: selectedDate != null ? formatDate(selectedDate) : label,
          suffixIcon: Icon(Icons.calendar_today),
          border: InputBorder.none,
        ),
        controller: TextEditingController(
          text: formatDate(selectedDate),
        ),
      ),
    );
  }

  bool isSaveButtonEnabled() {
    return selectedFarm != null &&
        selectedCrop != null &&
        selectedExpense != null &&
        selectedDate != null &&
        _confamount.text.isNotEmpty;
  }

  void saveExpenseData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Handle save logic using selected values (selectedFarm, selectedCrop, selectedEvent, selectedDate, _confamount.text)

      _confamount.clear();
      selectedFarm = null;
      selectedCrop = null;
      selectedExpense = [];
      selectedDate = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Expense data saved successfully!"),
        ),
      );
    }
  }
}
