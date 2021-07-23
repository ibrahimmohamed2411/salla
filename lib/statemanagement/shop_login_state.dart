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

  LoginModel? registerModel;
  Future<bool> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    bool status = false;
    await DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      status = registerModel!.status!;
    });
    return status;
  }

  void clear() {
    loginModel = null;
    registerModel = null;
  }
}
