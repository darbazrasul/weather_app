// auth_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({required this.isLoading, this.error});
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthState(isLoading: false));

  Future<void> login(String email, String password) async {
    emit(AuthState(isLoading: true));
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthState(isLoading: false));
    } catch (error) {
      emit(AuthState(isLoading: false, error: error.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthState(isLoading: true));
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(AuthState(isLoading: false));
    } catch (error) {
      emit(AuthState(isLoading: false, error: error.toString()));
    }
  }
}
