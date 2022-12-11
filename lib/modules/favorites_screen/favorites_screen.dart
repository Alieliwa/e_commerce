import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/models/home/home_model.dart';
import 'package:medica_zone_app/models/wishlist/wislistmodel.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/styles/colors.dart';
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  /* void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //wishlistModel.data!.items![index].product!
    print("*********************************************");
   /* print(
        HomeCubit.get(context).datafav!.data!.items![0].product!.sellingPrice);
    print(HomeCubit.get(context).datafav!.data!.items!.length);*/
     HomeCubit.get(context).getFavData();
    super.didChangeDependencies();
  }*/
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<HomeCubit>(context).getFavData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, HomeStates state) {
        if (state is AddItemsecssesToFavState) {}
      },
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.datafav != null,
          builder: (context) =>
          cubit.datafav != null && cubit.datafav!.data!.items!.length != 0
              ? productsBuilder(cubit.datafav!, cubit.homeModel!, context)
              : Center(child: Text("Whilist is empty")),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productsBuilder(
    wishlistProductModel wishlistModel, HomeModel homeModel, context) =>
    RefreshIndicator(
      onRefresh: () async {
        return await HomeCubit.get(context).getFavData();
      },
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildProducts(wishlistModel.data!.items![index], context, index),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: wishlistModel.data!.items!.length),
    );

Widget buildProducts(Items model, context, int index) => Container(
  color: AppCubit.get(context).isDark ? color : Colors.white,
  child: model.product != null
      ? Dismissible(
    key: Key(model.id.toString()),
    onDismissed: (direction) {
      HomeCubit.get(context).datafav!.data!.items!.removeAt(index);
      HomeCubit.get(context).removeFavData("${model.id}");
      showToast(
          message: "Deleted Successfully From Favourites",
          states: ToastStates.SUCCESS);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                color: Colors.white,
                child: Image(
                  image: NetworkImage(
                    "${model.product!.productThambnail}",
                  ),
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.product!.productNameEn!.toUpperCase()}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black.withOpacity(.7),
                    fontSize: 15.0,
                    height: 1.3,
                    fontWeight: FontWeight.bold),
              ),
              if (model.product!.discountPrice != null)
                Text(
                  "${model.product!.discountPrice} LE",
                  style: TextStyle(
                      fontSize: 17.0,
                      color: AppCubit.get(context).isDark
                          ? Colors.lightBlueAccent
                          : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              if (model.product!.discountPrice == null)
                SizedBox(
                  height: 10,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${model.product!.sellingPrice} EGP",
                    style: TextStyle(
                        decoration:
                        model.product!.discountPrice != null
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: model.product!.discountPrice != null
                            ? 14.0
                            : 17.0,
                        color: model.product!.discountPrice != null
                            ? Colors.grey
                            : AppCubit.get(context).isDark
                            ? Colors.lightBlueAccent
                            : Colors.black),
                  ),
                  Spacer(),
                  if (model.product!.discountPrice != null)
                    Text(
                      '${model.id}% OFF',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (model.product!.discountPrice == null)
                SizedBox(
                  height: 10,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (model.product!.discountPrice != null)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius:
                          BorderRadiusDirectional.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Discount",
                        style: TextStyle(
                            color: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  if (model.product!.discountPrice == null)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius:
                          BorderRadiusDirectional.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "New",
                        style: TextStyle(
                            color: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    "${model.product!.rate}",
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  )
      : Center(
      child: Text(
        "Item Not Found Data",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
);
