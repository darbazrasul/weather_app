// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/auth_controller.dart';
// import '../blocs/auth_bloc.dart';

// class AuthScreen extends StatelessWidget {
//   final AuthController _authController = Get.put(AuthController());
//   final AuthBloc _authBloc = Get.put(AuthBloc());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Getx Auth Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               onChanged: _authController.setEmail,
//               initialValue: _authController.email.value,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               onChanged: _authController.setPassword,
//               obscureText: true,
//               initialValue: _authController.password.value,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _authBloc.login,
//               child: const Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: _authBloc.register,
//               child: const Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weather_app/screens/wether_scree.dart.dart';
import '../controllers/auth_controller.dart';
import '../blocs/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController _authController = Get.put(AuthController());

  final Auth _authBloc = Get.put(Auth());

  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 11, right: 24, left: 24, bottom: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Вход',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const Text(
                'Введите данные для входа',
                style: TextStyle(
                  color: Color(0xff8799A5),
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged: _authController.email,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: _authController.password,
                     obscureText:_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible =! _isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xff0700FF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                       Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => const WeatherScreen()),
                         );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 5, 200),
                            borderRadius: BorderRadius.circular(24)),
                        child: const Center(
                          child: Text(
                            'Войти',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _authBloc.login,
                      
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: _authBloc.register,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
