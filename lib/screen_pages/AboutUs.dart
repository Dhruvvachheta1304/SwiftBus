import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        title: Text("About us",style: TextStyle(color: Colors.black,fontSize: 20),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our Bus Booking App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our bus booking app is designed to make your travel experience easy and stress-free. With our app, you can book bus tickets, view schedules and routes, and track your journey all in one place. Our goal is to provide you with the best possible travel experience, and we are committed to ensuring your safety, comfort, and convenience.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
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
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                launch('mailto: info@swiftbus.com');
              },
              child: Text(
                'Email: info@swiftbus.com',
                style: TextStyle(
                  fontSize: 16,
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
                  fontSize: 16,
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
