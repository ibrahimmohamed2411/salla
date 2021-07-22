import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:salla/network/local/cache_helper.dart';
import 'package:salla/network/remote/dio_helper.dart';
import 'package:salla/screens/login_screen.dart';
import 'package:salla/screens/on_boarding_screen.dart';
import 'package:salla/screens/register_screen.dart';
import 'package:salla/screens/search_screen.dart';
import 'package:salla/screens/shop_screen.dart';
import 'package:salla/statemanagement/shop_login_state.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/styles/themes.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  // final bool onBoarding;
  final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return Phoenix(
      key: Key('p'),
      child: MultiProvider(
        key: Key('m'),
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ShopLoginState(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ShopState(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Salla',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: startWidget,
          routes: {
            SearchScreen.route: (ctx) => SearchScreen(),
            OnBoardingScreen.route: (ctx) => OnBoardingScreen(),
            LoginScreen.route: (ctx) => LoginScreen(),
            RegisterScreen.route: (ctx) => RegisterScreen(),
            ShopScreen.route: (ctx) => ShopScreen(),
          },
        ),
      ),
    );
  }
}
