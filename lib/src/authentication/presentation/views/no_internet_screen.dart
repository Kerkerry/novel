import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width:200, height: 70, child: Icon(Icons.wifi_off_outlined, size: 60, color: Colors.grey,),),
          SizedBox(height: 10,),
           Text("No internet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),)
        ],
      )),
    );
  }
}