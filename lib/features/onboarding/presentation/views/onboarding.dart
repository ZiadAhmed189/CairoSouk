import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/Api/cache_helper.dart';
import '../../../login/presentation/views/login.dart';
import '../../data/onboard_model.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool check = false;

  int ind = 1;

  List<OnboardModel> model = [
    OnboardModel(title: "Welcome in our Cairo Souk", body: "Hello EveryBody"),
    OnboardModel(title: "We have the best prices on the market", body: ""),
    OnboardModel(
        title: "We support the Palestinian cause", body: "Free Palestine")
  ];

  var pagecont = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(
              width: 2,
            ),
            Text(
              "${ind}",
              style: Textstyle.defaultstylebold,
            ),
            Text(
              "/3",
              style: Textstyle.defaultstylebold.copyWith(color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                onsumbit();
              },
              child: Text(
                "SKIP",
                style: Textstyle.defaultstylebold,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pagecont,
                itemBuilder: (context, index) => Onboarding(model[index]),
                itemCount: model.length,
                onPageChanged: (value) {
                  setState(() {
                    ind = value + 1;
                  });
                  if (value == model.length - 1) {
                    check = true;
                  } else {
                    check = false;
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  count: model.length,
                  controller: pagecont,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      spacing: 5,
                      expansionFactor: 4,
                      dotWidth: 10),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (check) {
                      onsumbit();
                    } else {
                      pagecont.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Onboarding(OnboardModel modeel) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset(
              'assets/images/zooz.json',
              height: 250,
            ),
            SizedBox(
              height: 50,
            ),
            Text("${modeel.title}",
                style: Textstyle.defaultstylebold
                    .copyWith(color: Colors.black, fontSize: 24)),
            Text("${modeel.body}",
                style: Textstyle.defaultstylebold
                    .copyWith(color: Colors.grey, fontSize: 14))
          ],
        ),
      );
  void onsumbit() {
    CacheHelper.saveData(key: "OnBoarding", value: true).then((value) {
      if (value!) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
}
