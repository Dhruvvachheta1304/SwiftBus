import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class drop_dwon extends StatefulWidget {
  const drop_dwon({Key? key}) : super(key: key);

  @override
  State<drop_dwon> createState() => _drop_dwonState();
}

class _drop_dwonState extends State<drop_dwon> {
  List from_to_location_list = [
    "ahemdabad",
    "vadanagar",
    "ghandhinagar",
    "vadodara",
    "junagad",
    "Rajkot",
    "Morbi"
  ];
  var selectedValue2;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.9,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Gender*',
                              // style: font_style.white_400_16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: from_to_location_list.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                              overflow: TextOverflow.ellipsis,),
                          )).toList(),
                      value: selectedValue2,
                      onChanged: (value) {
                        setState(() {
                          selectedValue2 = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: EdgeInsets.zero,
                        width: SizeConfig.screenWidth * 0.9,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.yellow.withOpacity(
                                0.2)),
                          ),
                          color: Colors.blue.withOpacity(0.5),
                        ),
                        elevation: 0,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.yellow.withOpacity(0.2),
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: SizeConfig.screenWidth*0.9,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.2),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14),bottomRight: Radius.circular(14)),
                            border: Border.all(color: Colors.blue),

                          ),
                          elevation: 0,
                          scrollbarTheme: ScrollbarThemeData(
                            radius: Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
