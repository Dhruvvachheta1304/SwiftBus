import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:flutter/material.dart';

class floating_container extends StatelessWidget {
  const floating_container({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight*0.080,
      width: SizeConfig.screenWidth*0.160,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
      ),
      child: Icon(Icons.add, size: 25, color: Colors.black,),
    );
  }
}
