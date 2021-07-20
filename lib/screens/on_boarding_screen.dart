import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:salla/widgets/default_text_button.dart';
import 'package:salla/constants.dart';
import 'package:salla/models/boarding_model.dart';
import 'package:salla/network/local/cache_helper.dart';

import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String route = 'on-boarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DefaultTextButton(
            text: 'skip',
            onPressed: submit,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageIndicatorContainer(
                  length: 3,
                  align: IndicatorAlign.bottom,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.blue,
                  indicatorSelectorColor: Colors.deepOrange,
                  shape: IndicatorShape.circle(size: 15),
                  child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (ctx, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('indicator'),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast)
                        submit();
                      else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_sharp),
                    elevation: 0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                boardingModel.image,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            boardingModel.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            boardingModel.body,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      );
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      }
    });
  }
}
