import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/views/main_nav/main_nav_page.dart';
import 'package:task_manager/views/registration/regi_page.dart';
import 'package:task_manager/widgets/screen_bg.dart';

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onTapRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegiPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Text(
                "Get Started With",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              SizedBox(height: 25),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 20),

              FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavPage()),
                  );
                },
                child: Icon(Icons.arrow_forward_ios_outlined, size: 20),
              ),
              SizedBox(height: 70),

              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password...?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don,t have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: " Registration",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onTapRegistration,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
