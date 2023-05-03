import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvnDyLGaS2rDeKoMVQJDtoefxzEG8DKt7MYLoqkYaGl3ZYfc6VOiNzFENZ5SeuoJxa2k4&usqp=CAU",
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45))),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 9.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    "https://i.pinimg.com/474x/5d/05/96/5d0596ab050e94e1fe07687e107f61c9.jpg",
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Norhan Mohmed",
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "NorhanMohamed30@gmail.com",
                style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.notifications,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Notification",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Text(
                          "on",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                            fontWeight: FontWeight.w500,
                            color: Color(0xffE73c37),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.language,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Language",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Text(
                          "English",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Color(0xffE73c37),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30,
              ),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.security_rounded,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Security",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.color_lens,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Theme",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Text(
                          "Light Mode",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Color(0xffE73c37),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30,
              ),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.help,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Help & Support",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.mail_sharp,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Contact Us",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.lock,
                            color: Constants.secondryColor,
                          ),
                        ),
                        Text(
                          "Privacy Policy",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
