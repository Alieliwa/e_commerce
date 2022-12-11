import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/modules/search/search.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: AssetImage(
                      'assets/images/medical.png',
                    ),
                  ),
                  Text("Medica Zone"),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeMode();
                    },
                    icon: AppCubit.get(context).isDark
                        ? Icon(Icons.brightness_4_outlined)
                        : Icon(Icons.wb_sunny_sharp)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: cubit.items,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}