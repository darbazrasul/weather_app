import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class Auth extends GetxController {
  final AuthController _authController = Get.find();

  Future<void> login() async {
    if (_authController.email.isNotEmpty &&
        _authController.password.isNotEmpty) {
      await _authController.login();
    }
  }

  Future<void> register() async {
    if (_authController.email.isNotEmpty &&
        _authController.password.isNotEmpty) {
      await _authController.register();
    }
  }
}
