import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_cubit.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/models/cart/cart.dart';
import 'package:medica_zone_app/models/home/home_model.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/cubit/app_cubit.dart';
import 'package:medica_zone_app/shared/styles/colors.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var str = 0;

  @override
  void initState() {
    // TODO: implement initState
    //HomeCubit().getCartData();
    BlocProvider.of<HomeCubit>(context).getCartData();
    // BlocProvider.of<HomeCubit>(context)
    //     .dataCart!
    //     .data!
    //     .items!
    //     .forEach((element) {
    //   str += (int.parse(element.product!.sellingPrice.toString()) *
    //       int.parse(element.quantity.toString()));
    //   print(str);
    // });
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
          condition: true,
          builder: (context) => cubit.dataCart != null &&
              cubit.dataCart!.data!.items!.length != 0
              ? productsBuilder(cubit.dataCart!, cubit.homeModel!, context, str)
              : Center(child: Text("Cart is empty")),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productsBuilder(
    getCartModel cartModel, HomeModel homeModel, context, int str) =>
    RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<HomeCubit>(context).getCartData();
        BlocProvider.of<HomeCubit>(context)
            .dataCart!
            .data!
            .items!
            .forEach((element) {
          str += (int.parse(element.product!.sellingPrice.toString()) *
              int.parse(element.quantity.toString()));
          print(str);
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 1,
        child: Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 22),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildProducts(
                    cartModel.data!.items![index],
                    context,
                    index,
                  ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cartModel.data!.items!.length,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: defaultButton(
                      function: ()  {
                        // await HomeCubit.get(context)
                        //     .makePayment(context, str.toString());
                      },
                      text: "Pay",
                      isUpper: false,
                      redius: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget buildProducts(Items modelitem, context, index) => modelitem.product !=
    null
    ? Container(
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
                  "${modelitem.product!.productThambnail}",
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
              "${modelitem.product!.productNameEn!.toUpperCase()}",
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
            if (modelitem.product!.discountPrice != null)
              Text(
                "${modelitem.product!.discountPrice} EGP",
                style: TextStyle(
                    fontSize: 17.0,
                    color: AppCubit.get(context).isDark
                        ? Colors.lightBlueAccent
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            if (modelitem.product!.discountPrice == null)
              const SizedBox(
                height: 10,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${modelitem.product!.sellingPrice} EGP",
                  style: TextStyle(
                      decoration: modelitem.product!.discountPrice != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: modelitem.product!.discountPrice != null
                          ? 14.0
                          : 17.0,
                      color: modelitem.product!.discountPrice != null
                          ? Colors.grey
                          : AppCubit.get(context).isDark
                          ? Colors.lightBlueAccent
                          : Colors.black),
                ),
                Spacer(),
                if (modelitem.product!.discountPrice != null)
                  Text(
                    '${modelitem.product!.id}% OFF',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (modelitem.product!.discountPrice == null)
              SizedBox(
                height: 15,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (modelitem.product!.discountPrice != null)
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
                if (modelitem.product!.discountPrice == null)
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
                  "${modelitem.product!.rate}",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    HomeCubit.get(context)
                        .addToCart("${modelitem.product!.id}");
                    await BlocProvider.of<HomeCubit>(context)
                        .getCartData();
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    (HomeCubit.get(context)
                        .dataCart!
                        .data!
                        .items![index]
                        .quantity
                        .toString()),
                    style: TextStyle(fontSize: 23.0),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    HomeCubit.get(context).removeCartData(modelitem.id);
                    BlocProvider.of<HomeCubit>(context).getCartData();
                  },
                  mini: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child:HomeCubit.get(context).dataCart!.data!.items![index].quantity == 1 ? Icon(Icons.delete): Icon(Icons.minimize),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  ),
)
    : Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text("Item is not exist"),
);