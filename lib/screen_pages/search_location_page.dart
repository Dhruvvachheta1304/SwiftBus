import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common_variable/common_var.dart';

class search_location extends StatefulWidget {
  String? frompage;

  search_location({required this.frompage});

  @override
  State<search_location> createState() => _search_locationState();
}

class _search_locationState extends State<search_location> {

  List search_bus_list = [
    "Use Current Location",
    "B-best academy home & personal tuition, Ahmedabad",
    "B-best academy home & personal tuition, Ahmedabad",
  ];

  final _fuser = FirebaseAuth.instance;
  final _fuser_store= FirebaseFirestore.instance;

  var selected_index;
  // var selected_value;

  CollectionReference _search_collection = FirebaseFirestore.instance.collection("Locations");
  List Locations_var=[];
  List searchResult = [];
  TextEditingController searchbar=TextEditingController();
  TextEditingController searchbar1=TextEditingController();

  // getloc_fun() async {
  //   QuerySnapshot querysnapshot = await _search_collection.get();
  //   setState(() {
  //     books = querysnapshot.docs.map((e) => e.get("loc")).toList();
  //   });
  //
  //   print(books);
  // }

List books=[];
  // searchFromFirebase(String query) async {
  //   final result = await FirebaseFirestore.instance.collection("Locations")
  //       .where('loc', arrayContains: query)
  //       .get();
  //   setState(() {
  //     searchResult = result.docs.map((e) => e.data()).toList();
  //     print(searchResult);
  //   });
  //
  // }

  get_searchList() async {
    QuerySnapshot _search_qeurysnapshot = await _search_collection.get();
    _search_qeurysnapshot.docs!.forEach((e) {
      setState(() {
        books.add(e.get("loc"));
      });
    });
    // books= search_loc_List as List;
    print(books);
    print(books.length);

  }

  @override
  void initState() {
    super.initState();
    get_searchList();
  }

  @override
  Widget build(BuildContext context) {

    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Search"),
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back, size:20 ,color: Colors.black,)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              // controller: searchbar.text.isEmpty?searchbar1:searchbar1,
              controller: searchbar,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Here",
              ),
              onChanged: (String query) async {
                QuerySnapshot _search_qeurysnapshot = await _search_collection.get();
                final suggestions = _search_qeurysnapshot.docs.where((element) {
                  final exname=element.get("loc").toString();
                  final input = query.toString();
                  return exname.contains(input);
                }).toList();
                setState(() => books = suggestions);
              },
            ),
          ),
          searchbar.text.isEmpty?
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    setState(() {
                      if (widget.frompage=="from") {
                        selected_value= books[index];
                      } else {
                        selected_value2=books[index];
                      }
                      Get.to(home_page());
                    });
                  },
                  trailing: Icon(Icons.add,color: Colors.black,),
                  title: Text(books[index],style: TextStyle(
                      color: Colors.black
                  ),),
                );
              },
            ),
          ):
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    setState(() {
                      selected_value= books[index]['loc'].toString();
                      Get.to(home_page());
                    });
                  },
                  trailing: Icon(Icons.add,color: Colors.black,),
                  title: Text(books[index]["loc"].toString(),style: TextStyle(
                    color: Colors.black
                  ),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }



}
