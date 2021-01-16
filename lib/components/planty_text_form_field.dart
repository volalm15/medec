import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medec/constants.dart';
import 'package:medec/size_config.dart';

class PlantyTextFormField extends StatefulWidget {
  final String hintText;
  final Function validator;
  final bool isPassword;
  final bool isEmail;
  final bool isDate;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function onTap;
  final bool enabled;
  final List<TextInputFormatter> inputFormatter;
  final bool isNumber;
  final double height;
  final double width;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final String suffixText;
  PlantyTextFormField({
    this.focusNode,
    this.height,
    this.prefixIcon,
    this.width,
    this.hintText,
    this.isNumber = false,
    this.validator,
    this.isDate = false,
    this.isPassword = false,
    this.isEmail = false,
    this.controller,
    this.onTap,
    this.onEditingComplete,
    this.enabled,
    this.inputFormatter,
    this.suffixText,
  });

  @override
  _PlantyTextFormFieldState createState() => _PlantyTextFormFieldState();
}

class _PlantyTextFormFieldState extends State<PlantyTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ? true : false;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final passwordIcon = IconButton(
      icon: Icon(Icons.remove_red_eye),
      onPressed: _toggle,
      color: primaryIconColor,
    );
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: widget.width,
          child: TextFormField(
            focusNode: widget.focusNode,
            onEditingComplete: widget.onEditingComplete,
            inputFormatters: widget.inputFormatter,
            enabled: widget.enabled,
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(15)),
            onTap: widget.onTap,
            decoration: InputDecoration(
              suffixText: widget.suffixText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              fillColor: Colors.white,
              labelText: widget.hintText,
              labelStyle: TextStyle(
                  color: primaryTextColor,
                  fontSize: getProportionateScreenHeight(15)),
              suffixIcon: widget.isPassword ? passwordIcon : null,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: primaryIconColor,
                size: 20,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.height, horizontal: 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: stateError,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              errorStyle: TextStyle(height: 0, color: Colors.transparent),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: stateError,
                  width: 2,
                ),
              ),
            ),
            obscureText: _obscureText,
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: getTextInputType(),
            cursorColor: primaryColor,
          ),
        ),
      ),
    );
  }

  TextInputType getTextInputType() {
    if (widget.isEmail) return TextInputType.emailAddress;

    if (widget.isNumber) return TextInputType.number;

    if (widget.isDate) return TextInputType.datetime;

    return TextInputType.text;
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}
