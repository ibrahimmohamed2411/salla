import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:salla/models/categories_model.dart';
import 'package:salla/models/change_favourites_model.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/network/remote/dio_helper.dart';
import 'package:salla/network/remote/end_points.dart';
import 'package:salla/screens/categories_screen.dart';
import 'package:salla/screens/favourites_screen.dart';
import 'package:salla/screens/products_screen.dart';
import 'package:salla/screens/settings_screen.dart';

import '../constants.dart';

class ShopState extends ChangeNotifier {
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    notifyListeners();
  }

  HomeModel? homeModel;
  Future<HomeModel?> getHomeData() async {
    if (homeModel != null) {
      return homeModel;
    }
    try {
      var response = await DioHelper.getData(
        url: HOME,
        token: token,
      );
      await getCategories();
      await getFavourites();
      homeModel = HomeModel.fromJson(response.data);
    } catch (error) {
      print(error);
    }
    return homeModel;
  }

  late CategoriesModel categoriesModel;
  Future<CategoriesModel> getCategories() async {
    var response = await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    );

    return categoriesModel = CategoriesModel.fromJson(response.data);
  }

  late ChangeFavouritesModel changeFavouritesModel;
  late FavouritesModel favouritesModel;

  Future<void> changeFavouriteState(dynamic product, int id) async {
    var response =
        await DioHelper.postData(token: token, url: FAVOURITES, data: {
      'product_id': id,
    });

    if (product is Product) {
      changeFavouritesModel =
          ChangeFavouritesModel.fromJson(response.data); //Message
      product.inFavorites = !product.inFavorites;
      getFavourites();
    } else {
      await getFavourites();
      homeModel!.data.products.firstWhere((Product element) {
        if (element.id == id) {
          element.inFavorites = !element.inFavorites;
          return true;
        }
        return false;
      });
    }
    notifyListeners();
  }

  Future<FavouritesModel> getFavourites() async {
    var response = await DioHelper.getData(
      url: FAVOURITES,
      token: token,
    );
    return favouritesModel = FavouritesModel.fromJson(response.data);
  }
}
