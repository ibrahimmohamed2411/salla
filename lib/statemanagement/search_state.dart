import 'package:flutter/foundation.dart';
import 'package:salla/constants.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/network/remote/dio_helper.dart';
import 'package:salla/network/remote/end_points.dart';

class SearchState extends ChangeNotifier {
  SearchModel? searchModel;
  Future<void> search(String text) async {
    var response = await DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    );
    searchModel = SearchModel.fromJson(response.data);
    notifyListeners();
  }
}
