import 'package:flutter/material.dart';
import 'package:guru/home_page.dart';
import 'package:guru/pallete.dart';
import 'package:device_preview/device_preview.dart';


void main() {
   runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true, // 🛠 REQUIRED for DevicePreview
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false ,
      title: 'GURU ',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor
        )
      ),
      home: const HomePage(),
    );
  }
}
