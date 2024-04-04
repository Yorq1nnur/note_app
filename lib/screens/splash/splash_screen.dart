import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/screens/global_screen/global_screen.dart';
import '../../utils/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async{
   await Future.delayed(
      const Duration(seconds: 2),
    );
    if(mounted){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GlobalScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Lottie.asset(
          AppImages.splashLottie,
        ),
      ),
    );
  }
}
