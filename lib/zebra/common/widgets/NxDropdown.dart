import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/dao/models/UserModel.dart';
import 'package:sheti_next/zebra/dao/DbHelper.dart';

class NxDropdown extends StatefulWidget {
  @override
  State<NxDropdown> createState() => _NxDropdownState();
}

class _NxDropdownState extends State<NxDropdown> {
  // chat gpt code
   final DbHelper dbHelper = DbHelper();
   List<UserModel> userslist=[];
  List<DropdownMenuItem<UserModel>> dropdownItems = [];
  //String selectOption = "Select option";
  UserModel? selectedUser;
  DropdownButtonFormField? hint;

  // working code
 // final DatabaseHelper databaseHelper = DatabaseHelper();
 // List<Country> countries = [];
  //List<DropdownMenuItem<Country>> dropdownItems = [];
 // Country? selectedCountry;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsers();

  }

   Future<void> _loadUsers() async {
     List<UserModel> fetchedUsers = await dbHelper.getAllUsers();
     setState(() {
       userslist = fetchedUsers;
       dropdownItems = userslist.map((user) {
         return DropdownMenuItem<UserModel>(
           value: user,
           child: Text(user.firstName),
         );
       }).toList();
       /* if (countries.isNotEmpty) {
        selectedCountry = countries[0]; // Set the first country as selected by default
      }
*/
     });
   }


  // Color? NxboxColor;
  // Color? NxdropDownColor;
  // String? NxHintText;
  // bool NxIsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: userslist.isEmpty
            ? CircularProgressIndicator()
            : DropdownButton<UserModel>(
          hint: Text("Select User"),
          value: selectedUser,
          items: dropdownItems,
          onChanged: (UserModel? userModel) {
            setState(() {
              selectedUser = userModel;
            });
            if (userModel != null) {
              print('Selected User: ${userModel.firstName}');
            }
          },
        ),
      );

  }


}
