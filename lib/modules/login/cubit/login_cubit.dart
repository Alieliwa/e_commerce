import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/models/login/login_model.dart';
import 'package:medica_zone_app/modules/login/cubit/login_state.dart';
import 'package:medica_zone_app/shared/network/end_points.dart';
import 'package:medica_zone_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  bool passwordVisible = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }

  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // print(value.data.toString());
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailureState(error.toString()));
    });
  }
}
