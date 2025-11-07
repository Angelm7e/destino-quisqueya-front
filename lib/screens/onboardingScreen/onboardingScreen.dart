import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisqueya_front/screens/onboardingScreen/introPage1.dart';
import 'package:destino_quisqueya_front/screens/onboardingScreen/introPage2.dart';
import 'package:destino_quisqueya_front/screens/onboardingScreen/introPage3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [Intropage1(), Intropage2(), Intropage3()],
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip button
                GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                //next or done button
                isLastPage
                    ? GestureDetector(
                        onTap: () async {
                          //TODO: Remover el comentarios
                          // SharedPreferences prefs =

                          //     await SharedPreferences.getInstance();
                          // await prefs.setBool(CacheAcess.showOnboarding, false);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (_) => false,
                          );
                        },
                        child: Text(
                          S.of(context).getStarted,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          S.of(context).next,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
