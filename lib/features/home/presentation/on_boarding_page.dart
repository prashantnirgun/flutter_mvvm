import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpp/core/routes/app_routes.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        next: Icon(Icons.arrow_forward_rounded, color: Colors.black),
        done: Text(
          'Get Started',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        dotsDecorator: DotsDecorator(
          color: Colors.grey,
          activeColor: Colors.black,
        ),
        onDone: () async {
          debugPrint('Start Application');
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('hasSeenOnboarding', true);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, AppRoutes.LOGINPAGE);
        },
        pages: getPages(),
        controlsMargin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 16,
          left: 6,
          right: 6,
        ),
      ),
    );
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        decoration: PageDecoration(imageFlex: 1),
        image: Image.asset('assets/images/on_board/product.png'),
        titleWidget: Text(
          'Discover Amazing Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        body:
            "Explore thousands of products across categories — from fashion to electronics, all in one place. Find what you love effortlessly.",
      ),
      PageViewModel(
        decoration: PageDecoration(imageFlex: 1),
        image: Image.asset('assets/images/on_board/wallet.png'),
        titleWidget: Text(
          'Fast & Secure Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        body:
            "Enjoy quick, safe payments and doorstep delivery. Track your orders in real-time with just a tap.",
      ),
      PageViewModel(
        decoration: PageDecoration(imageFlex: 1),
        image: Image.asset('assets/images/on_board/deal.png'),
        titleWidget: Text(
          'Exclusive Deals & Discounts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        body:
            "Save more with our daily offers, coupons, and member-only discounts. Shopping smarter has never been easier.",
      ),
    ];
  }
}
