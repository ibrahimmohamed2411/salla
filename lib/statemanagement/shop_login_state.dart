import 'package:flutter/foundation.dart';
import 'package:salla/models/login_model.dart';
import 'package:salla/network/remote/dio_helper.dart';
import 'package:salla/network/remote/end_points.dart';

class ShopLoginState extends ChangeNotifier {
  LoginModel? loginModel;
  Future<bool> userLogin(
      {required String email, required String password}) async {
    bool status = false;
    await DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      status = loginModel!.status!;
    });
    return status;
  }
}
