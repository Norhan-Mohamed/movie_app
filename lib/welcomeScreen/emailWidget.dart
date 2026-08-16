import 'package:flutter/material.dart';

final Color facebookColor = const Color(0xff39579A);
final Color twitterColor = const Color(0xff00ABEA);
final Color instaColor = const Color(0xffBE2289);
final Color whatsappColor = const Color(0xff075E54);
final Color linkedinColor = const Color(0xff0085E0);
final Color githubColor = const Color(0xff202020);
final Color googleColor = const Color(0xffDF4A32);

class CustomWidgets {
  static Widget socialButtonRect(title, color, icon, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: color, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget socialButtonCircle(color, icon, {iconColor, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          )),
    );
  }
}
