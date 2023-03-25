import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/constant.dart';

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
  /* bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                Row(
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: ' Name ',
                    contentPadding: const EdgeInsets.only(left: 10),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Constants.secondryColor,
                    ),
                    suffixIcon: null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: ' Email ',
                    contentPadding: const EdgeInsets.only(left: 10),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Constants.secondryColor,
                    ),
                    suffixIcon: null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                SizedBox(
                  height: 20,
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
                TextFormField(
                  //   controller: model.passwordController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.only(left: 10),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Constants.secondryColor,
                    ),
                    suffixIcon: null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
            SizedBox(
              height: 30,
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
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
