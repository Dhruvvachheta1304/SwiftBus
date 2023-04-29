import 'package:bluebus/admin_screens/addmin_home_screen.dart';
import 'package:bluebus/admin_screens/payment_option_available_by_admin.dart';
import 'package:bluebus/admin_screens/travel_add_details.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:flutter/material.dart';


class bottm_navbar_page extends StatefulWidget {
  const bottm_navbar_page({Key? key}) : super(key: key);

  @override
  State<bottm_navbar_page> createState() => _bottm_navbar_pageState();
}

class _bottm_navbar_pageState extends State<bottm_navbar_page> {

  int current_index=0;

  List bottom_bar_list=[
    admin_home_page(),
    travell_add_details(),
    payment_option_by_admin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottom_bar_list[current_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,

        selectedLabelStyle: TextStyle(color: Colors.white),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white ,
        onTap: ( index) {
          setState(() {
            current_index=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dataset_outlined, color: Colors.black,), label: "travel"),
          BottomNavigationBarItem(icon: Icon(Icons.payments, color: Colors.black,), label: "payment"),

        ],
      ),
    );
  }
}
