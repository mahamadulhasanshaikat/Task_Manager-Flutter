import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/utils/asset_path.dart';
import 'package:task_manager/views/main_nav/main_nav_page.dart';

import '../../utils/widgets/screen_bg.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
    moveToNextPage();
  }

  Future moveToNextPage() async {
    await Future.delayed(Duration(seconds: 3));

    AuthController.getUserData();
    bool isLogin = await AuthController.isUserLogin();
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => isLogin ? MainNavPage() : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBG(
        child: Center(
          child: Image.asset(width: 300, height: 300, AssetPath.logo),
        ),
      ),
    );
  }
}
