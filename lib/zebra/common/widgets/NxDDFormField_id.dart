import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxDDFormField_id extends StatefulWidget {
  final int? selectedItemId;
  final String label;
  final String hint;
  final Map<int, String> items;
  final Function(int?) onChanged;

  const NxDDFormField_id({
    Key? key,
    required this.selectedItemId,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NxDDFormField_id> createState() => _NxDDFormField_idState();
}

class _NxDDFormField_idState extends State<NxDDFormField_id> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 57,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<int>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width:1,color: ColorConstants.enabledFieldBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: ColorConstants.enabledFieldBorderColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: ColorConstants.disabledFieldBorderColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1,color: ColorConstants.errorFieldBorderColor)),

            fillColor: Colors.white,
            filled: true,
            labelText: widget.selectedItemId != null ? widget.label : null,labelStyle:TextStyle(fontWeight: FontWeight.normal,color:ColorConstants.fieldLabelTextColor),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            isDense: true,
          ),
          hint: Text(widget.hint, style: TextStyle(color: ColorConstants.fieldHintTextColor, fontWeight: FontWeight.normal)),
          value: widget.selectedItemId,
          onChanged: widget.onChanged,
          items: widget.items.keys.map((int itemId) {
            return DropdownMenuItem<int>(
              value: itemId,
              child: Text(widget.items[itemId]!, style: TextStyle( color: ColorConstants.dropdownElementTextColor,fontWeight: FontWeight.normal)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
