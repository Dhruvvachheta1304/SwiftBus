import 'package:bluebus/admin_screens/addmin_home_screen.dart';
import 'package:bluebus/common_pages/commmon_icon_page.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class payment_option_by_admin extends StatefulWidget {
  const payment_option_by_admin({Key? key}) : super(key: key);

  @override
  State<payment_option_by_admin> createState() =>
      _payment_option_by_adminState();
}

class _payment_option_by_adminState extends State<payment_option_by_admin> {
  var google_pay = false;
  var phone_pay = false;
  var paytm_pay = false;
  var cash_on_deliveri = false;

  final _fpaymetn_auth = FirebaseAuth.instance;
  final _f_payment_storeg = FirebaseFirestore.instance;

  add_payment_option_fin() async {
    await _f_payment_storeg.collection("Payment Option").add({
      "Google pay": "",
      "Phone Pay": "",
      "Paytm Pay": "",
      "Cash On Deliveri": "",
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(gradient: theemecolor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Payment Option",
            style: textstyle.travelstyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth * 0.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //google pay
                  Container(
                      width: SizeConfig.screenWidth * 0.6,
                      child: CheckboxListTile(
                        value: google_pay,
                        onChanged: (val) {
                          setState(() {
                            google_pay = val!;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        title: Text(
                          "Google Pay :",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )),

                  //phone pay
                  Container(
                      width: SizeConfig.screenWidth * 0.6,
                      child: CheckboxListTile(
                        value: phone_pay,
                        onChanged: (val) {
                          setState(() {
                            phone_pay = val!;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        title: Text(
                          "Phone Pay :",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )),

                  // paytm pay
                  Container(
                      width: SizeConfig.screenWidth * 0.6,
                      child: CheckboxListTile(
                        value: paytm_pay,
                        onChanged: (val) {
                          setState(() {
                            paytm_pay = val!;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        title: Text(
                          "Paytm Pay :",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )),

                  //cod
                  Container(
                      width: SizeConfig.screenWidth * 0.6,
                      child: CheckboxListTile(
                        value: cash_on_deliveri,
                        onChanged: (val) {
                          setState(() {
                            cash_on_deliveri = val!;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        title: Text(
                          "Cash On Deliveri :",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )),

                  //save container:
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 50,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Get.to(admin_home_page());
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: SizeConfig.screenHeight * 0.050,
                        width: SizeConfig.screenWidth * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
