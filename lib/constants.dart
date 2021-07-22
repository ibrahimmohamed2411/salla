import 'package:flutter/material.dart';
import 'package:salla/screens/login_screen.dart';

import 'models/boarding_model.dart';
import 'network/local/cache_helper.dart';

const List<BoardingModel> boarding = const [
  const BoardingModel(
    title: 'On Boarding 1 Title',
    body: 'on Boarding 1 Body',
    image: 'assets/images/onbroading_0.svg',
  ),
  const BoardingModel(
    title: 'On Boarding 2 Title',
    body: 'on Boarding 2 Body',
    image: 'assets/images/onbroading_1.svg',
  ),
  const BoardingModel(
    title: 'On Boarding 3 Title',
    body: 'on Boarding 3 Body',
    image: 'assets/images/onbroading_2.svg',
  ),
];
void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      //Navigator.of(context).pushReplacementNamed(LoginScreen.route);
    }
  });
}

String? token = '';
