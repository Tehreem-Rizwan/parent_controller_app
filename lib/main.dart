import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control_app/view/screens/launch/splash_screen.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //locale: DevicePreview.locale(context),
      //  builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
