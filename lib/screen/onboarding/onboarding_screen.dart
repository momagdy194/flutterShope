import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'onboardingmodel.dart';
import '../utilities/screenconfigration.dart';

class SingleOnBoardingScreen extends StatelessWidget {
  ScreenConfig screenConfig;
  OnBoardingModel onBoardingModel;
  Widgetsize widgetsize;
  SingleOnBoardingScreen(this.onBoardingModel);

  @override
  Widget build(BuildContext context) {
  screenConfig= ScreenConfig(context);
  widgetsize=Widgetsize(screenConfig);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 8,
            height: MediaQuery.of(context).size.height * .25,
            child: Image(
              image: ExactAssetImage(onBoardingModel.image),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            onBoardingModel.title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize:widgetsize.titleFontSize),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            onBoardingModel.description,
            style:
                TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400, fontSize: widgetsize.descriptionFontSize, height: 1.5),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
