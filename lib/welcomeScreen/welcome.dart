import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/welcomeScreen/login.dart';
import 'package:movie_app/welcomeScreen/registration.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    super.key,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage('assets/movie.png'),
                      height: 300,
                      width: 300,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    "Watch thousand of hit \n movies and TV series \n for free",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                      fontSize: 30,
                      color: Colors.white,
                      letterSpacing: 1,
                      wordSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Constants.secondryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Constants.secondryColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
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
                              fontSize: 10,
                              color: Colors.orange,
                              letterSpacing: 1,
                              wordSpacing: 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
