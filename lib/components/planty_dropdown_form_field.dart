import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medec/constants.dart';

class PlantyDropdownFormField<T> extends StatefulWidget {
  final List<DropdownMenuItem> choices;
  final double width;
  final Function onChanged;
  final Function onSaved;
  final IconData prefixIcon;
  final T value;
  final String label;
  final double height;
  PlantyDropdownFormField(
      {this.choices,
      this.label,
      this.width,
      this.onChanged,
      this.onSaved,
      this.prefixIcon,
      this.value,
      this.height});

  @override
  _PlantyDropdownFormFieldState<T> createState() =>
      _PlantyDropdownFormFieldState<T>();
}

class _PlantyDropdownFormFieldState<T>
    extends State<PlantyDropdownFormField<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: Container(
          width: widget.width,
          child: DropdownButtonFormField<T>(
            value: widget.value,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: widget.height),
              labelText: widget.label,
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: primaryIconColor,
                size: 18,
              ),
              labelStyle: TextStyle(
                color: primaryTextColor,
              ),
            ),
            items: widget.choices,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
          ),
        ),
      ),
    );
  }
}
