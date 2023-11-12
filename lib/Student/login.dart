import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/Student/bc_home_page.dart';
import 'package:studentlogin/Student/student_home_page.dart';
import 'package:studentlogin/admin/admin_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() async {
    final String enteredEmail = emailController.text;
    final String enteredPassword = passwordController.text;

    
    final String apiUrl = 'http://10.2.28.201:3000/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': enteredEmail, 'password': enteredPassword}),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StudentHomePage(studentId: emailController.text)));
      } else {
        // Login failed
        print('Login failed: ${response.body}');
      }
    } catch (error) {
      print('Error in login: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxHeight: 200, maxWidth: double.infinity),
                decoration: BoxDecoration(
                  color: Color(0xFF0028A8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.elliptical(700, 590),
                    bottomRight: Radius.elliptical(700, 590),
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/basketball_Login.jpeg'),
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF0028A8).withOpacity(0.4),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset('images/email.svg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset('images/password.svg'),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff0028a8),
                                Color(0xff2a54d5),
                                Color(0xff0028a8),
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
