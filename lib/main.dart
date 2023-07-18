import 'package:assignment_2/configs/languageConfig.dart';
import 'package:assignment_2/screens/loginPage.dart';
import 'package:assignment_2/screens/signUpPage.dart';
import 'package:assignment_2/utils/appBind.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Locale currentLang = Locale('en', 'US');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat app',
      translations: LanguageConfig(),
      locale: currentLang,
      fallbackLocale: const Locale('en' ,'Us'),
      initialBinding: AppBinding(),
      home: const LoginPage(),
    );
  }
}
