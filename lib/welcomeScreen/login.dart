import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/welcomeScreen/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/helper.dart';
import '../network/loginDataBase.dart';
import 'emailWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final uEmailController = TextEditingController();
  final uPasswordController = TextEditingController();
  bool passToggle = true;
  late final DbHelper dbHelper;

  InputDecoration _fieldDecoration({
    required String hintText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black45),
      filled: true,
      fillColor: Constants.fourthColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Constants.secondryColor, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  void dispose() {
    uEmailController.dispose();
    uPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveSession(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_name', name);
    await prefs.setString('email', email);
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String uEmail = uEmailController.text.trim();
    String uPassword = uPasswordController.text;

    try {
      final userData = await dbHelper.getLoginUser(uEmail, uPassword);
      if (userData != null) {
        await _saveSession(userData.user_name ?? '', userData.email ?? '');
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const NavigationBarPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        if (!mounted) return;
        alertDialog(context, "Error: User Not Found");
      }
    } catch (error) {
      if (!mounted) return;
      alertDialog(context, "Error: Login Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Image(
                  height: 80,
                  width: 80,
                  image: AssetImage('assets/movie2.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Text(
                          "E-mail address",
                          style: TextStyle(
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: uEmailController,
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        ),
                        cursorColor: Constants.secondryColor,
                        decoration: _fieldDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Constants.secondryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (!validateEmail(value.trim())) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontFamily:
                                    'FontsFree-Net-SFProText-Regular.ttf',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            "forget password?",
                            style: TextStyle(
                                fontFamily:
                                    'FontsFree-Net-SFProText-Regular.ttf',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passToggle,
                        controller: uPasswordController,
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        ),
                        cursorColor: Constants.secondryColor,
                        decoration: _fieldDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Constants.secondryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            icon: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 50,
                  thickness: .5,
                  color: Constants.secondryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomWidgets.socialButtonCircle(
                        facebookColor, FontAwesomeIcons.facebookF,
                        iconColor: Colors.white, onTap: () {
                      Fluttertoast.showToast(msg: 'I am circle facebook');
                    }),
                    CustomWidgets.socialButtonCircle(
                        googleColor, FontAwesomeIcons.googlePlusG,
                        iconColor: Colors.white, onTap: () {
                      Fluttertoast.showToast(msg: 'I am circle google');
                    }),
                    CustomWidgets.socialButtonCircle(
                        whatsappColor, FontAwesomeIcons.whatsapp,
                        iconColor: Colors.white, onTap: () {
                      Fluttertoast.showToast(msg: 'I am circle whatsapp');
                    }),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 55,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.secondryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don`t have an account?",
                      style: TextStyle(
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                          fontSize: 15,
                          color: Colors.white,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    TextButton(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                            fontSize: 15,
                            color: Colors.orange,
                            letterSpacing: 1,
                            wordSpacing: 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
