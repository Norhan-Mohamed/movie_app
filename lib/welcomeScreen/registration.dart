import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/constant.dart';

import '../models/helper.dart';
import '../models/userModel.dart';
import '../network/loginDataBase.dart';
import 'emailWidget.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final userNameController = TextEditingController();
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
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Constants.secondryColor, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    String uname = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String cpassword = cPasswordController.text;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (password != cpassword) {
      alertDialog(context, 'Password Mismatch');
      return;
    }

    UserModel uModel = UserModel(uname, email, password);
    try {
      await dbHelper.saveData(uModel);
      if (!mounted) return;
      alertDialog(context, "Successfully Saved");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } catch (error) {
      if (!mounted) return;
      alertDialog(context, "Error: Data Save Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldTextStyle = TextStyle(
      color: Constants.primaryColor,
      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
    );

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Image(
                  height: 80,
                  width: 80,
                  image: AssetImage('assets/movie2.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Become a member!",
                    style: TextStyle(
                        fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Text(
                          "Your name",
                          style: TextStyle(
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: userNameController,
                        style: fieldTextStyle,
                        cursorColor: Constants.secondryColor,
                        decoration: _fieldDecoration(
                          hintText: 'Name',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Constants.secondryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: fieldTextStyle,
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
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        obscureText: passToggle,
                        controller: passwordController,
                        style: fieldTextStyle,
                        cursorColor: Constants.secondryColor,
                        keyboardType: TextInputType.visiblePassword,
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
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Text(
                          "Password confirm",
                          style: TextStyle(
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: cPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passToggle,
                        style: fieldTextStyle,
                        cursorColor: Constants.secondryColor,
                        decoration: _fieldDecoration(
                          hintText: 'Confirm Password',
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
                  height: 30,
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
                const SizedBox(height: 30),
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
                    onPressed: signUp,
                    child: const Text(
                      'Sign up',
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
                      "Do you have an account?",
                      style: TextStyle(
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                          fontSize: 15,
                          color: Colors.white,
                          letterSpacing: 1,
                          wordSpacing: 1),
                    ),
                    TextButton(
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                            fontSize: 15,
                            color: Colors.orange,
                            letterSpacing: 1,
                            wordSpacing: 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
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
