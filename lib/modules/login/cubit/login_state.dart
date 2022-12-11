
import 'package:medica_zone_app/models/login/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginFailureState extends LoginStates {
  final String error;

  LoginFailureState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}
