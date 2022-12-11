import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/layout/cubit/home_states.dart';
import 'package:medica_zone_app/models/cart/cart.dart';
import 'package:medica_zone_app/models/categories/categories_model.dart';
import 'package:medica_zone_app/models/deals/deals.dart';
import 'package:medica_zone_app/models/home/home_model.dart';
import 'package:medica_zone_app/models/login/login_model.dart';
import 'package:medica_zone_app/models/slider/slider_model.dart';
import 'package:medica_zone_app/models/wishlist/wislistmodel.dart';
import 'package:medica_zone_app/modules/account/account.dart';
import 'package:medica_zone_app/modules/cart/cart.dart';
import 'package:medica_zone_app/modules/categories/categories.dart';
import 'package:medica_zone_app/modules/deals/deals.dart';
import 'package:medica_zone_app/modules/favorites_screen/favorites_screen.dart';
import 'package:medica_zone_app/modules/products/products.dart';
import 'package:medica_zone_app/shared/components/components.dart';
import 'package:medica_zone_app/shared/components/constants.dart';
import 'package:medica_zone_app/shared/network/end_points.dart';
import 'package:medica_zone_app/shared/network/local/cache_helper.dart';
import 'package:medica_zone_app/shared/network/remote/dio_helper.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    DealsScreen(),
    CartScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet_giftcard_sharp),
      label: "Categories",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.discount_outlined),
      label: "Deals",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Cart",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: "Acc",
    ),
  ];
  int currentIndex = 0;

  changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favourites = {};

  dynamic getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, authToken: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourites,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeFailureState(error.toString()));
    });
  }

  SliderModel? sliderModel;

  void getSliderImages() {
    emit(SliderLoadingState());
    DioHelper.getData(url: SLIDER).then((value) {
      sliderModel = SliderModel.fromJson(value.data);
      emit(SliderLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(SliderFailureState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  dynamic getCategoriesData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      showFullText(error.toString());
      emit(CategoriesFailureState(error.toString()));
    });
  }

  DealsModel? dealsModel;

  dynamic getDealsData() {
    emit(DealsLoadingState());
    DioHelper.getData(url: DEALS, authToken: token).then((value) {
      dealsModel = DealsModel.fromJson(value.data);
      emit(DealsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DealsFailureState(error.toString()));
    });
  }

  HomeModel? SearchResults;

  void getSearch({String text = ""}) {
    emit(SearchLoadingState());
    DioHelper.getData(url: SEARCH + text).then((value) {
      SearchResults = HomeModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchFailureState(error.toString()));
    });
  }

  User? userDataModel;

  void getUserData() {
    emit(UserProfileLoadingState());
    DioHelper.getData(url: Profile, authToken: token).then((value) {
      userDataModel = User.fromJson(value.data);
      print(value.data.toString());
      emit(UserProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserProfileFailureState(error.toString()));
    });
  }

  //Payment functions using stripe
  Map<String, dynamic>? paymentIntentData;

  // Future<void> makePayment(context, amount) async {
  //   try {
  //     paymentIntentData = await createPaymentIntent(
  //         amount, 'EGP'); //json.decode(response.body);
  //     // print('Response body==>${response.body.toString()}');
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret:
  //                     paymentIntentData!['client_secret'],
  //                 applePay: true,
  //                 googlePay: true,
  //                 testEnv: true,
  //                 style: ThemeMode.dark,
  //                 merchantCountryCode: 'US',
  //                 merchantDisplayName: 'Kamal'))
  //         .then((value) {});
  //
  //     ///now finally display payment sheeet
  //
  //     displayPaymentSheet(context);
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //   }
  // }
  //
  // displayPaymentSheet(context) async {
  //   try {
  //     await Stripe.instance
  //         .presentPaymentSheet(
  //             parameters: PresentPaymentSheetParameters(
  //       clientSecret: paymentIntentData!['client_secret'],
  //       confirmPayment: true,
  //     ))
  //         .then((newValue) {
  //       print('payment intent' + paymentIntentData!['id'].toString());
  //       print(
  //           'payment intent' + paymentIntentData!['client_secret'].toString());
  //       print('payment intent' + paymentIntentData!['amount'].toString());
  //       print('payment intent' + paymentIntentData.toString());
  //       //orderPlaceApi(paymentIntentData!['id'].toString());
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("paid successfully")));
  //
  //       paymentIntentData = null;
  //     }).onError((error, stackTrace) {
  //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
  //     });
  //   } on StripeException catch (e) {
  //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               content: Text("Cancelled "),
  //             ));
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L7NLXHjmyadU3ZuYImx0V8m3VjDP66HyzZiz8vrU6zRX86BN04T6Vsf6AicLh6j70AD9EPAtR1Iy3DMAkl86g5o00iimZR7ZS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 99;
    return a.toString();
  }

  HomeModel? addFavModel;

  dynamic changefav(String ProductId) {
    DioHelper.postData(
      url: FAVOURITEADD + ProductId,
      data: {
        'id': ProductId,
      },
    ).then((value) {
      addFavModel = HomeModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavState());
    }).catchError((onError) {
      emit(ShopErrorChangeFavState());
    });
  }

  wishlistProductModel? datafav;

  dynamic getFavData() {
    DioHelper.getData(url: FAVOURITES,
        authToken: token).then((value) {
      datafav = wishlistProductModel.fromJson(value.data);
      print(datafav!.data!.items!.length);
      emit(AddItemsecssesToFavState());
    }).catchError((error) {
      print(error.toString());
      emit(AddItemerrorToFavState());
    });
  }

  wishlistProductModel? removefav;

  dynamic removeFavData(String ProductId) {
    print(ProductId);
    DioHelper.getData(url: FAVOURITEREMOVE + ProductId, authToken: token)
        .then((value) {
      removefav = wishlistProductModel.fromJson(value.data);
      emit(RemoveItemsecssesToFavState());
    }).catchError((error) {
      print(error.toString());
      emit(RemoveItemerrorToFavState());
    });
  }

  getCartModel? dataCart;

  dynamic getCartData() {
    print(CacheHelper.getData(key: tokenKeyValue));
    DioHelper.getData(
      url: CARTGET,
      authToken: CacheHelper.getData(key: tokenKeyValue),
    ).then((value) {
      emit(LoadedCartGetData());
      dataCart = getCartModel.fromJson(value.data);
      //print(dataCart!.data!.items!.length);
      emit(SecssesCartGetData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCartGetData());
    });
  }

  getCartModel? addCart;

  void addToCart(String ProductId) {
    DioHelper.postData(
      authToken: CacheHelper.getData(key: tokenKeyValue),
      url: CARTADD + ProductId,
      data: {
        'product_id': ProductId,
      },
    ).then((value) {
      addCart = getCartModel.fromJson(value.data);
      emit(ShopSuccessChangeCartAddState());
    }).catchError((onError) {
      emit(ShopErrorChangeCartAddState());
    });
  }

  getCartModel? removeCart;

  dynamic removeCartData(int id) {
    print(id);
    DioHelper.getData(
      url: CARTMOVE + id.toString(),
      // authToken: token,
    ).then((value) {
      removeCart = getCartModel.fromJson(value.data);
      print(value.data);
      emit(RemoveItemsecssesCartState());
    }).catchError((error) {
      print("${error.toString()}");
      emit(RemoveItemerrorCartState());
    });
  }
}
