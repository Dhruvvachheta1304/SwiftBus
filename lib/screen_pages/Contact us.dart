import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Contact us",style: TextStyle(color: Colors.black,fontSize: 20),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or feedback, please don\'t hesitate to contact us:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 18),
            GestureDetector(
              onTap: (){
                launch('mailto: info@swiftbus.com');
              },
              child: Text(
                'Email: info@swiftbus.com',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                launch('tel: 9157299925') ;
              },
              child: Text(
                'Phone: 9157299925',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}
