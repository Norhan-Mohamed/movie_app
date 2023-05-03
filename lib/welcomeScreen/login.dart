import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/welcomeScreen/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../models/helper.dart';
import '../models/userModel.dart';
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
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formField = GlobalKey<FormState>();
  final uEmailController = TextEditingController();
  final uPasswordController = TextEditingController();
  bool passToggle = true;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    ToastContext().init(context);
  }

  login() async {
    String uEmail = uEmailController.text;
    String uPassword = uPasswordController.text;

    if (uEmail.isEmpty) {
      alertDialog(context, "Please Enter User Email");
    } else if (uPassword.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uEmail, uPassword).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => NavigationBarPage()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id.toString());
    sp.setString("user_name", user.user_name.toString());
    sp.setString("email", user.email.toString());
    sp.setString("password", user.password.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 80,
              width: 80,
              image: AssetImage('assets/movie2.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
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
                Row(
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    key: _formField,
                    keyboardType: TextInputType.emailAddress,
                    controller: uEmailController,
                    decoration: InputDecoration(
                      hintText: ' Email ',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      contentPadding: const EdgeInsets.only(left: 10),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Constants.secondryColor,
                      ),
                      suffixIcon: null,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 30)),
                    Text(
                      "Passord",
                      style: TextStyle(
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Text(
                      "forget password?",
                      style: TextStyle(
                          fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: passToggle,
                    controller: uPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      contentPadding: const EdgeInsets.only(left: 10),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Constants.secondryColor,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password required";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Divider(
              height: 60,
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
            SizedBox(
              height: 60,
            ),
            Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Constants.secondryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Constants.secondryColor),
                ),
                onPressed: () => login(),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don`t have an account?",
                  style: TextStyle(
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 1,
                      wordSpacing: 1),
                ),
                TextButton(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        fontSize: 15,
                        color: Colors.orange,
                        letterSpacing: 1,
                        wordSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
