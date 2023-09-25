import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/main_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxString email = ''.obs;
  RxString password = ''.obs;

  Future<void> login() async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      print('Logged in user: ${credential.user?.email}');
      GetStorage().write('isLoggedIn', true);
      Get.off(() => const MainScreen());
    } catch (error) {
      print('Login error: $error');
    }
  }

  Future<void> register() async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      print('Registered user: ${credential.user?.email}');
      GetStorage().write('isLoggedIn', true);
      Get.off(() => const MainScreen()); // Navigate to MainScreen
    } catch (error) {
      print('Registration error: $error');
    }
  }
}
