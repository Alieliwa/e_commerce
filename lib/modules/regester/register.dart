import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/modules/login/login.dart';
import 'package:medica_zone_app/modules/regester/cubit/register_cubit.dart';
import 'package:medica_zone_app/modules/regester/cubit/register_state.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/components/constants.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var passwordConfiramtion = TextEditingController();
  var name = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.loginModel.status == true) {
            CacheHelper.saveData(
                key: tokenKeyValue,
                value: 'Bearer ' + state.loginModel.accessToken!)
                .then((value) {
              token = "${'Bearer ' + state.loginModel.accessToken!}";
              // showToast(
              //     message: state.loginModel.message,
              //     states: ToastStates.SUCCESS);
              navigateAndFinish(context, LoginScreen());
            });
          } else {
            showToast(
                message: state.loginModel.message, states: ToastStates.FAILURE);
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Medica Zone"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultFormField(
                          style: TextStyle(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          keyboard_type: TextInputType.name,
                          controller_type: name,
                          label_text: "Name",
                          prefix_icon: Icons.person,
                          Validate: (nameCheck) {
                            if (nameCheck!.isEmpty) {
                              return "Name mustn't be empty";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          style: TextStyle(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black),
                          keyboard_type: TextInputType.emailAddress,
                          controller_type: email,
                          label_text: "Email",
                          prefix_icon: Icons.email,
                          Validate: (emailCheck) {
                            if (emailCheck!.isEmpty) {
                              return "Email mustn't be empty";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black),
                        keyboard_type: TextInputType.visiblePassword,
                        controller_type: password,
                        label_text: "Password",
                        prefix_icon: Icons.lock,
                        suffix_icon: cubit.suffix,
                        isVisible: cubit.passwordVisible,
                        isPasswordVisible: () {
                          cubit.changePasswordVisibility();
                        },
                        // onSubmit: (value) {
                        //   if (formKey.currentState!.validate()) {
                        //     cubit.userRegister(
                        //         email: email.text,
                        //         password: password.text,
                        //         name: name.text,
                        //         passwordConfiramation: passwordConfiramtion.text);
                        //   }
                        // },
                        Validate: (passwordCheck) {
                          if (passwordCheck!.isEmpty) {
                            return "Password mustn't be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black),
                        keyboard_type: TextInputType.visiblePassword,
                        controller_type: passwordConfiramtion,
                        label_text: "passwordConfiramtion",
                        prefix_icon: Icons.lock,
                        suffix_icon: cubit.suffix,
                        isVisible: cubit.passwordVisible,
                        isPasswordVisible: () {
                          cubit.changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                                email: email.text,
                                password: password.text,
                                name: name.text,
                                passwordConfiramation:
                                passwordConfiramtion.text);
                          }
                        },
                        Validate: (passwordCheck) {
                          if (passwordCheck!.isEmpty) {
                            return "Password mustn't be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                          text: "Sign Up",
                          redius: 60.0,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  passwordConfiramation:
                                  passwordConfiramtion.text);
                            }
                          },
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
