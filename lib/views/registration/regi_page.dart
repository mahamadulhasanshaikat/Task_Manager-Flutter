import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/views/login/login_page.dart';
import 'package:task_manager/widgets/screen_bg.dart';

class RegiPage extends StatefulWidget {
  const new({super.key});

  @override
  State<RegiPage> createState() => _RegiPageState();
}

class _RegiPageState extends State<RegiPage> {
  void onTapLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
                "Join with us",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(hintText: 'First Name'),
              ),
              SizedBox(height: 25),
              TextFormField(decoration: InputDecoration(hintText: 'Last Name')),

              SizedBox(height: 25),
              TextFormField(decoration: InputDecoration(hintText: 'Mobile')),
              SizedBox(height: 25),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 20),

              FilledButton(
                onPressed: () {},
                child: Icon(Icons.arrow_forward_ios_outlined, size: 20),
              ),
              SizedBox(height: 70),

              Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: " Login",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onTapLogin,
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
