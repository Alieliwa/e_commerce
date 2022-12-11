import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/modules/login/cubit/login_cubit.dart';
import 'package:medica_zone_app/modules/login/cubit/login_state.dart';
import 'package:medica_zone_app/modules/login/login.dart';
import 'package:medica_zone_app/modules/regester/register.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';


class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  var name = TextEditingController();
  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = LoginCubit.get(context).loginModel;
        name.text = (model == null) ? '' : model.user!.name!;
        email.text = (model == null) ? '' : model.user!.email!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is! LoginSuccessState)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ahlan! Nice to meet you",
                          style: TextStyle(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black.withOpacity(.7),
                              fontSize: 20.0,
                              height: 1.3,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "The region's favourite online marketplace",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.yellowAccent,
                                  child: IconButton(
                                      onPressed: () {
                                        navigateTo(context, LoginScreen());
                                      },
                                      icon: Icon(Icons.person)),
                                ),
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black.withOpacity(.7),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.yellowAccent,
                                  child: IconButton(
                                      onPressed: () {
                                        navigateTo(context, RegisterScreen());
                                      },
                                      icon: Icon(Icons.person_add_alt)),
                                ),
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black.withOpacity(.7),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  if (state is LoginSuccessState)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            keyboard_type: TextInputType.name,
                            controller_type: name,
                            label_text: "Name",
                            style: TextStyle(
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black),
                            prefix_icon: Icons.person,
                            Validate: (String? value) {
                              if (value!.isNotEmpty) {
                                "Name mustn't be empty!";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            keyboard_type: TextInputType.emailAddress,
                            controller_type: email,
                            label_text: "Email",
                            prefix_icon: Icons.email_rounded,
                            style: TextStyle(
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black),
                            Validate: (String? value) {
                              if (value!.isNotEmpty) {
                                "Email mustn't be empty!";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: "Sign Out",
                            redius: 20)
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}