import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return InkWell(
          onTap: () {
            HomeCubit.get(context).changeBottomNav(0);
          },
          child: RefreshIndicator(
            onRefresh: () async {
              return await HomeCubit.get(context).getCategoriesData();
            },
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCategoriesItems(
                    cubit.categoriesModel!.data!.items![index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.categoriesModel!.data!.items!.length),
          ),
        );
      },
    );
  }
}