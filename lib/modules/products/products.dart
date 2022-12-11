import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/models/categories/categories_model.dart';
import 'package:medica_zone_app/models/home/home_model.dart';
import 'package:medica_zone_app/models/product/Product.dart';
import 'package:medica_zone_app/models/slider/slider_model.dart';
import 'package:medica_zone_app/modules/product_details/product_details.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // if (state is FavouritesChangeSuccessState) {
        //   if (state.changeFavouritesModel.status! == false) {
        //     showToast(
        //         message: state.changeFavouritesModel.message,
        //         states: ToastStates.FAILURE);
        //   }
        // }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.sliderModel != null &&
              cubit.homeModel != null &&
              cubit.categoriesModel != null,
          builder: (context) => productsBuilder(cubit.sliderModel!,
              cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(SliderModel sliderModel, HomeModel homeModel,
      CategoriesModel categoriesModel, context) =>
      RefreshIndicator(
        onRefresh: () async {
          return await HomeCubit.get(context).getHomeData();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: CarouselSlider(
              //       items: sliderModel.data!.items!
              //           .map(
              //             (e) => Image(
              //           image: NetworkImage("${e.sliderImg}"),
              //           width: double.infinity,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //           .toList(),
              //       options: CarouselOptions(
              //         height: MediaQuery.of(context).size.height * .2,
              //         aspectRatio: 16 / 9,
              //         viewportFraction: 1.0,
              //         initialPage: 0,
              //         enableInfiniteScroll: true,
              //         reverse: false,
              //         autoPlay: true,
              //         autoPlayInterval: Duration(seconds: 3),
              //         autoPlayAnimationDuration: Duration(milliseconds: 8010),
              //         autoPlayCurve: Curves.fastOutSlowIn,
              //         enlargeCenterPage: true,
              //         scrollDirection: Axis.horizontal,
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          HomeCubit.get(context).changeBottomNav(1);
                        },
                        highlightColor: Colors.grey[300],
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildCategories(
                                categoriesModel.data!.items![index], context),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10.0),
                            itemCount: categoriesModel.data!.items!.length),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Products",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Container(
                  color: Colors.grey[400],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.56,
                    children: List.generate(
                      homeModel.data!.products!.length,
                          (index) => InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                ProductDetails(
                                    homeModel.data!.products![index]));
                          },
                          child: buildProducts(
                              homeModel.data!.products![index], context)),
                    ),
                  ))
            ],
          ),
        ),
      );

  Widget buildProducts(Product model, context) => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
              // color: Colors.grey,
        color: AppCubit.get(context).isDark ? color : Colors.white60,
      ),

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
                      "${model.productThambnail}",
                    ),
                    width: double.infinity,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    HomeCubit.get(context).changefav("${model.id}");
                    showToast(
                        message: "Added Successfully To Favourites",
                        states: ToastStates.SUCCESS);
                    // print(model.id);
                  },
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    size: 25.0,
                    color: Colors.grey,
                    //HomeCubit.get(context).favourites[model.id]!
                    //                           ?Colors.red:
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.productNameEn!.toUpperCase()}",
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
                if (model.discountPrice != null)
                  Text(
                    "${model.discountPrice} EGP",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: AppCubit.get(context).isDark
                            ? Colors.lightBlueAccent
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                if (model.discountPrice == null)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${model.sellingPrice} EGP",
                      style: TextStyle(
                          decoration: model.discountPrice != null
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: model.discountPrice != null ? 14.0 : 17.0,
                          color: model.discountPrice != null
                              ? Colors.grey
                              : AppCubit.get(context).isDark
                              ? Colors.lightBlueAccent
                              : Colors.black),
                    ),
                    Spacer(),
                    if (model.discountPrice != null)
                      Text(
                        '${model.id}% OFF',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (model.discountPrice == null)
                  SizedBox(
                    height: 15,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (model.discountPrice != null)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius:
                            BorderRadiusDirectional.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Discount",
                          style:
                          TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                      ),
                    if (model.discountPrice == null)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius:
                            BorderRadiusDirectional.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "New",
                          style:
                          TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                      ),
                    Spacer(),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      "${model.rate}",
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
    ),
  );

  Widget buildCategories(CategoryItems model, context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: 80,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                  "${model.categoryIcon}"),
              fit: BoxFit.cover,
            )),
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(
          "${model.categoryNameEn}",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}