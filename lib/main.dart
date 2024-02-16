import 'package:dretmox_walpaper/veiws/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       builder: FToastBuilder(),
        

      debugShowCheckedModeBanner: false,
      title: 'Dretmox Wallpaper',
      theme: ThemeData(

         primaryColor: Colors.white,
      ),
      home: const Home(),
    );
  }
}
