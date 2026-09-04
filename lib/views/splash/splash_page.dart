import 'package:flutter/material.dart';
import 'package:task_manager/utils/asset_path.dart';

import '../../widgets/screen_bg.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
