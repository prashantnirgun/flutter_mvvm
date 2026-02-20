import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bpp/core/constants/app_constant.dart';
// token checks removed; session state determines navigation
import 'package:bpp/core/routes/app_routes.dart';

import 'package:bpp/features/authentication/presentation/bloc/session/session_block.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_state.dart';

import 'package:bpp/features/authentication/presentation/pages/login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;
  @override
  void initState() {
    super.initState();
    // SessionBloc already loads saved session on creation; we listen for
    // the resolved session state in the widget tree and navigate when ready.
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) async {
        if (state.status == SessionStatus.unknown) return;
        if (_navigated) return;
        _navigated = true;

        String nextPage;
        if (state.status == SessionStatus.authenticated) {
          nextPage = AppRoutes.DASHBOARDPAGE;
        } else {
          final prefs = await SharedPreferences.getInstance();
          final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
          nextPage = hasSeenOnboarding
              ? AppRoutes.LOGINPAGE
              : AppRoutes.ONBOARDINGPAGE;
        }

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, nextPage);
      },
      child: Scaffold(
        backgroundColor: Colors.orange,
        //backgroundColor: Color.fromARGB(255, 235, 163, 91),
        //backgroundColor: Color(0xFF9D4D6F),
        body: Container(
          width: double.infinity,
          //color: Colors.amber,
          padding: EdgeInsets.only(top: 250, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 80),
              SizedBox(height: 11),
              Text(
                AppConstants.APPNAME,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 11),
              Text(
                'Your smart shopping companion.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 21),
              Container(
                height: 51,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Color(0xFFFA9938), fontSize: 16),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Powered by The Software Source',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
