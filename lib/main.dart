import 'package:bluebus/admin_screens/addmin_home_screen.dart';
import 'package:bluebus/admin_screens/bottom_navbar.dart';
import 'package:bluebus/common_variable/common_var.dart';
import 'package:bluebus/screen_pages/DROP%20DOWNPAGE.dart';
import 'package:bluebus/screen_pages/Login_singup_page.dart';
import 'package:bluebus/screen_pages/buy_ticket_page.dart';
import 'package:bluebus/screen_pages/drping_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:bluebus/screen_pages/passanger_details_page.dart';
import 'package:bluebus/screen_pages/reset_password_page.dart';
import 'package:bluebus/screen_pages/sign_up_page.dart';
import 'package:bluebus/screen_pages/ticket_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Splash.dart';
import 'admin_screens/payment_option_available_by_admin.dart';
import 'admin_screens/travel_add_details.dart';
Future<void> main() async {

   await WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   var user=await SharedPreferences.getInstance();
   String id = user.getString("user_share_pre").toString();

   runApp(MyApp(id: id,));
}

class MyApp extends StatefulWidget {
  String? id;

  MyApp({required this.id});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: travell_add_details(),
      // home: drop_dwon(),
      home: Splash()

      // widget.id==null || widget.id.toString()=="null"?login_singup_page():widget.id.toString()=="admin@gmail.com"?bottm_navbar_page():home_page(),
    );
  }


}



