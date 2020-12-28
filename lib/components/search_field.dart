import 'package:flutter/material.dart';

import '../size_config.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: getProportionateScreenWidth(300),
        height: getProportionateScreenWidth(55),
        child: TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search for something…",
            hintStyle: TextStyle(
                fontSize: getProportionateScreenWidth(15), color: Colors.grey),
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ),
    );
  }
}
