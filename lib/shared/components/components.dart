import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medica_zone_app/models/categories/categories_model.dart';
import 'package:medica_zone_app/modules/login/login.dart';
import 'package:medica_zone_app/shared/components/constants.dart';
import 'package:medica_zone_app/shared/network/local/cache_helper.dart';

Widget defaultButton(
    {double width = double.infinity,
      Color background = Colors.blue,
      double redius = 0.0,
      bool isUpper = true,
      @required VoidCallback? function,
      @required String? text}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text!.toUpperCase() : text!,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16),
        ),
      ),
    );

Widget defaultFormField({
  @required TextInputType? keyboard_type,
  @required TextEditingController? controller_type,
  @required String? label_text,
  @required IconData? prefix_icon,
  IconData? suffix_icon,
  TextStyle? style,
  Function(String)? onChange,
  Function(String)? onSubmit,
  @required String? Function(String?)? Validate,
  VoidCallback? isPasswordVisible,
  bool isVisible = false,
}) =>
    TextFormField(
      style: style,
      keyboardType: keyboard_type,
      controller: controller_type,
      obscureText: isVisible,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: Validate,
      decoration: InputDecoration(
        labelText: label_text,
        prefixIcon: Icon(prefix_icon),
        suffixIcon: suffix_icon != null
            ? IconButton(onPressed: isPasswordVisible, icon: Icon(suffix_icon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);

void showToast({
  @required String? message,
  @required ToastStates? states,
}) {
  Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: identifyColor(states!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, FAILURE, WARNING }

Color identifyColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.FAILURE:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }
  return color;
}

void signOut(context) {
  CacheHelper.removeData(key: tokenKeyValue).then((value) {
    if (value == true) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void showFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.blueGrey,
  ),
);

Widget buildProductsItem(model, context, {bool oldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(
                "${model!.productThambnail}",
              ),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0 && oldPrice)
              Container(
                color: Colors.red,
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Text(
                  "Discount",
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.0,
                      height: 1.3,
                      fontWeight: FontWeight.bold)),
              Spacer(),
              Row(
                children: [
                  Text(
                    "${model.price.round()}",
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0 && oldPrice)
                    Text(
                      "${model.oldPrice.round()}",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 11.0,
                          color: Colors.grey),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        // HomeCubit.get(context).changeFavourites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                        // HomeCubit.get(context).favourites[model.id]!
                        //     ? Colors.blue
                        //     : Colors.grey[400],
                        Colors.grey[400],
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget buildCategoriesItems(CategoryItems models, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  "${models.categoryIcon}"),
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Text(
          "${models.categoryNameEn!.toUpperCase()}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 17.0,
          ),
        ),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios_outlined, color: Colors.blueAccent),
    ],
  ),
);
