import 'package:flutter/material.dart';
import 'package:mygeneralshope/screen/home_page.dart';
import 'package:mygeneralshope/screen/onboarding/onboardingmodel.dart';
import 'package:mygeneralshope/screen/utilities/screenconfigration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './onboarding_screen.dart';
import '../utilities/colorutilities.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double ScreenWidth;
  double ScreenHeight;
  int CurrentIndex = 0;

  PageController _pageController;
  List<OnBoardingModel> screens = [
    OnBoardingModel(
        image: 'assets/images/dashboard3.jpg',
        title: 'Welcome!',
        description:
            ' I\'m fired up and tired of the way that things have been, oh-ooh  The way that things have been, oh-ooh'),
    OnBoardingModel(
        image: 'assets/images/dashboard2.jpg',
        title: 'Add To Card !',
        description:
            ' I\'m fired up and tired of the way that things have been, oh-ooh  The way that things have been, oh-ooh'),
    OnBoardingModel(
        image: 'assets/images/dashboard1.jpg',
        title: 'Enjoy Purcchase',
        description:
            ' I\'m fired up and tired of the way that things have been, oh-ooh  The way that things have been, oh-ooh')
  ];

  ScreenConfig screenConfig;
  Widgetsize widgetSize;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenWidth = MediaQuery.of(context).size.width;
    ScreenHeight = MediaQuery.of(context).size.height;
    screenConfig = ScreenConfig(context);
    widgetSize = Widgetsize(screenConfig);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              width: ScreenWidth,
              height: ScreenHeight,
              child: PageView.builder(
                itemBuilder: (BuildContext context, int position) {
                  return SingleOnBoardingScreen(screens[position]);
                },
                controller: _pageController,
                itemCount: screens.length,
                onPageChanged: (int index) {
                  setState(() {
                    CurrentIndex = index;
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(ScreenHeight * .15)),
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawDots(screens.length)),
            ),
          ),
          (CurrentIndex == screens.length - 1)
              ? _drawStrartboutton()
              : Container(),
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qnt) {
    List<Widget> widget = [];
    for (int i = 0; i < qnt; i++) {
      widget.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: (i == CurrentIndex)
              ? ScreenUtilities.mainBlue
              : ScreenUtilities.lightGray,
        ),
        width: widgetSize.screenDotsWeight,
        height: widgetSize.screenDotsHeight,
        margin: (i == qnt - 1)
            ? EdgeInsets.only(right: 0)
            : EdgeInsets.only(right: 20),
      ));
    }
    return widget;
  }

  Widget _drawStrartboutton() {
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(ScreenHeight * .09)),
        child: SizedBox(
          width: widgetSize.bottomWidth,
          height: widgetSize.bottomheight,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              color: ScreenUtilities.mainBlue,
              child: Text(
                'Start',
                style: TextStyle(
                    letterSpacing: 4,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
              onPressed: () async {
//                SharedPreferences prefs = await SharedPreferences.getInstance();
//                prefs.setBool('is_seen', true);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return HomePage();
                }));
              }),
        ),
      ),
    );
  }
}
