import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trigon_application/Screens/bottom_nav.dart';
// ignore: unused_import
import 'dart:math' as math;

import '../Constants/colors.dart';

import 'find_evs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ignore: unused_field
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav(0))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteC,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 300,
                width: 600,
                child: const Center(
                  child: Image(
                      // color: whiteC,
                      height: 300,
                      image: AssetImage(
                        'assets/images/splash.png',
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Get Direction',
              style: TextStyle(
                  color: blackC, fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
