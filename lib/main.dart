import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tpl_interview/api/sheets/google_sheet.dart';
import 'package:tpl_interview/entry/login_screen.dart';
import 'package:tpl_interview/home_screen/home_screen_view.dart';
import 'package:tpl_interview/question_screen/question_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetClass().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Interview App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home:   LoginScreen(),
    );
  }
}
