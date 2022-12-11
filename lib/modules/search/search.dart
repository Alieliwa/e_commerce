import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/modules/product_details/product_details.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/styles/colors.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      keyboard_type: TextInputType.text,
                      controller_type: searchController,
                      label_text: "search",
                      prefix_icon: Icons.search,
                      Validate: (String? search) {
                        if (search!.isEmpty) {
                          return "Type Words to search";
                        }
                        return null;
                      },
                      onChange: (value) {
                        cubit.getSearch(text: value);
                      },
                      // onSubmit: (String text) {
                      //   HomeCubit.get(context).searchProducts(text);
                      // },
                      style: TextStyle(
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                navigateTo(
                                    context,
                                    ProductDetails(cubit.SearchResults!
                                        .data!.products![index]));
                              },
                              child: buildProductsItem(
                                  HomeCubit.get(context)
                                      .SearchResults!
                                      .data!
                                      .products![index],
                                  context),
                            ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: HomeCubit.get(context)
                                .SearchResults!
                                .data!
                                .products!
                                .length),
                      ),
                    if (state is SearchFailureState)
                      Text(
                        'Not Found!!',
                        style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black.withOpacity(.7),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget buildProductsItem( model, context) => Container(
  color: AppCubit.get(context).isDark ? color : Colors.white,
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
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                // HomeCubit.get(context)
                //     .changeFavourites(productsModel.id);
                print(model.id);
              },
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 22.0,
                color: Colors.blueGrey,
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
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Discount",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                if (model.discountPrice == null)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "New",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
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
);