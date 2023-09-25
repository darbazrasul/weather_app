import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
        fontFamily: "Ubuntu",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.black, fontSize: 32,
            height: 1.125, // 36 / 32 = 1.125 (approx)
          ),
          titleSmall: TextStyle(
            color: Colors.grey, fontSize: 15,
            height: 1.125, // 36 / 32 = 1.125 (approx)
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
