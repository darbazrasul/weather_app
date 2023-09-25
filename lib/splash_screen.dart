import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';
import 'package:weather_app/main_screen.dart';
import 'package:weather_app/screens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final GetStorage _box = GetStorage();
    final bool isLoggedIn = _box.read('isLoggedIn') ?? false;
    return Scaffold(
      body: SplashView(
        showStatusBar: true,
        logo: const Text(
          'WEATHER\nSERVICE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        loadingIndicator: const Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            'dawn is coming soon',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        bottomLoading: true,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0700FF),
            Color(0xFF000000),
          ],
        ),
        done: Done(
          isLoggedIn ? const MainScreen() : AuthScreen(),
        ),
      ),
    );
  }
}
