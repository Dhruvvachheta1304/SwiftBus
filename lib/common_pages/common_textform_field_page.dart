import 'package:flutter/material.dart';

import 'height_width_page.dart';

class textformfiled extends StatelessWidget {
  String?hinttext;

  var  hintstyle;
  var width;


  textformfiled({required this.hinttext,required this.hintstyle, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: width,
      child: TextFormField(
        autofocus: false,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,)
          ),
          hintText: hinttext,
          hintStyle: hintstyle,
        ),
      ),
    );
  }
}
