import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygeneralshope/screen/onboarding/onboarding.dart';
import 'package:mygeneralshope/screen/utilities/colorutilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screen/utilities/screenconfigration.dart';

void main() async {
//  SharedPreferences  prefs = await SharedPreferences.getInstance();
//bool isSeen=prefs.getBool('is_seen');
//Widget homepage=HomePage();
//if(!isSeen||isSeen==null){
//  homepage=OnBoarding();
//}
  runApp(GeneralShop());
}

class GeneralShop extends StatelessWidget {
//final Widget homepage;
//GeneralShop(this.homepage);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'General Shope',
      home: OnBoarding(),
      theme: ThemeData(


          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            display1: TextStyle(
                color: ScreenUtilities.darkGray,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                fontSize: 18,

            ),

            display2: TextStyle(
              color: ScreenUtilities.darkGray,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 22,
              height: 2,
              letterSpacing: 1.5

            ),
            headline: TextStyle(
              color: ScreenUtilities.textColor,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
            fontSize: 18
            ),
            subhead:   TextStyle(
              color: ScreenUtilities.darkGray,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 16

          ),
            title: TextStyle(
                color: ScreenUtilities.textColor,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: TextStyle(
                  color: ScreenUtilities.textColor,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: ScreenUtilities.textColor,
            labelStyle: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 22,
                fontWeight: FontWeight.w700),
            unselectedLabelColor: ScreenUtilities.unselected,
            unselectedLabelStyle: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 22,
                fontWeight: FontWeight.w700),
            labelPadding:
                EdgeInsets.only(right: 16, left: 16, bottom: 12, top: 16),
            indicatorSize: TabBarIndicatorSize.label,
          )),
    );
  }
}
